// lib/features/tts_player/data/repositories/voice_repository_impl.dart
// =============================================================================

import 'dart:async';
import 'dart:io';
import 'dart:convert';

import 'package:archive/archive_io.dart';
import 'package:http/http.dart' as http;
import 'package:isar/isar.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:rxdart/rxdart.dart';

import '../../../../core/error/failures.dart';
import '../../domain/entities/voice_model.dart';
import '../../domain/repositories/voice_repository.dart';
import '../models/voice_model_dto.dart';

/// URL of the remote curated voice catalogue JSON.
/// Format: list of objects matching [VoiceModel.fromJson] schema.
const String kVoiceCatalogueUrl =
    'https://raw.githubusercontent.com/your-org/open-reader-voices/main/catalogue.json';

class VoiceRepositoryImpl implements VoiceRepository {
  VoiceRepositoryImpl({required Isar isar}) : _isar = isar;

  final Isar _isar;

  // ── Streams ────────────────────────────────────────────────────────────────
  final BehaviorSubject<List<VoiceModel>> _voiceListSubject =
  BehaviorSubject.seeded([]);

  final BehaviorSubject<Map<String, double>> _progressSubject =
  BehaviorSubject.seeded({});

  // Active download cancellation tokens (voiceId → CancelToken).
  final Map<String, bool> _cancelledDownloads = {};

  @override
  Stream<List<VoiceModel>> get voiceListStream => _voiceListSubject.stream;

  @override
  Stream<Map<String, double>> get downloadProgressStream =>
      _progressSubject.stream;

  // ── Catalogue ──────────────────────────────────────────────────────────────

  @override
  Future<List<VoiceModel>> getAvailableVoices() async {
    // Always start from what we have persisted locally.
    final localDtos =
    await _isar.voiceModelDtos.where().findAll();
    final localMap = {for (final dto in localDtos) dto.id: dto.toDomain()};

    List<VoiceModel> remoteVoices = [];
    try {
      final response = await http
          .get(Uri.parse(kVoiceCatalogueUrl))
          .timeout(const Duration(seconds: 10));

      if (response.statusCode == 200) {
        final jsonList =
        (jsonDecode(response.body) as List).cast<Map<String, dynamic>>();
        remoteVoices = jsonList
            .map((json) => VoiceModel.fromJson(json))
            .where((v) => !localMap.containsKey(v.id)) // don't overwrite local
            .toList();
      }
    } on Exception {
      // Offline: silently fall back to local list.
    }

    // Merge: local voices first, then remote-only.
    final merged = [
      ...localMap.values,
      ...remoteVoices,
    ]..sort((a, b) {
      if (a.isSelected) return -1;
      if (b.isSelected) return 1;
      if (a.status == VoiceStatus.local &&
          b.status != VoiceStatus.local) return -1;
      if (b.status == VoiceStatus.local &&
          a.status != VoiceStatus.local) return 1;
      return a.displayName.compareTo(b.displayName);
    });

    _voiceListSubject.add(merged);
    return merged;
  }

  // ── Download ───────────────────────────────────────────────────────────────

  @override
  Future<void> downloadVoice(String voiceId) async {
    final current = _voiceListSubject.value;
    final voice = current.firstWhere(
          (v) => v.id == voiceId,
      orElse: () => throw VoiceImportFailure('Voice $voiceId not found.'),
    );

    if (voice.remoteZipUrl == null) {
      throw VoiceImportFailure('Voice $voiceId has no remote URL.');
    }

    _cancelledDownloads.remove(voiceId);
    _updateVoiceInList(voice.copyWith(status: VoiceStatus.downloading));

    try {
      final voiceDir = await _voiceDirectory(voiceId);

      // Stream the download with progress tracking.
      final request = http.Request('GET', Uri.parse(voice.remoteZipUrl!));
      final response = await http.Client().send(request);

      final totalBytes = response.contentLength ?? voice.sizeBytes;
      var receivedBytes = 0;
      final chunks = <List<int>>[];

      await for (final chunk in response.stream) {
        if (_cancelledDownloads[voiceId] == true) {
          _updateVoiceInList(voice.copyWith(status: VoiceStatus.remote));
          _updateProgress(voiceId, remove: true);
          return;
        }
        chunks.add(chunk);
        receivedBytes += chunk.length;
        _updateProgress(voiceId, value: receivedBytes / totalBytes);
      }

      // Write zip to temp file, then extract.
      final zipBytes =
      chunks.expand((c) => c).toList();
      await _extractZip(
        zipBytes: zipBytes,
        targetDir: voiceDir,
        voiceId: voiceId,
      );

      final onnxPath = _findFileInDir(voiceDir, '.onnx');
      final jsonPath = _findFileInDir(voiceDir, '.json');

      final updatedVoice = voice.copyWith(
        status: VoiceStatus.local,
        onnxModelPath: onnxPath,
        configJsonPath: jsonPath,
      );

      await _persist(updatedVoice);
      _updateVoiceInList(updatedVoice);
      _updateProgress(voiceId, remove: true);
    } catch (e) {
      _updateVoiceInList(voice.copyWith(status: VoiceStatus.remote));
      _updateProgress(voiceId, remove: true);
      throw VoiceImportFailure('Download failed for $voiceId: $e');
    }
  }

  @override
  Future<void> cancelDownload(String voiceId) async {
    _cancelledDownloads[voiceId] = true;
  }

  // ── Import ─────────────────────────────────────────────────────────────────

  @override
  Future<VoiceModel> importVoiceFromZip(String zipFilePath) async {
    final zipFile = File(zipFilePath);
    if (!zipFile.existsSync()) {
      throw VoiceImportFailure('File not found: $zipFilePath');
    }

    final zipBytes = await zipFile.readAsBytes();
    final archive = ZipDecoder().decodeBytes(zipBytes);

    final onnxEntry =
        archive.files.where((f) => f.name.endsWith('.onnx')).firstOrNull;
    final jsonEntry =
        archive.files.where((f) => f.name.endsWith('.json')).firstOrNull;

    if (onnxEntry == null || jsonEntry == null) {
      throw VoiceImportFailure(
          'Invalid voice pack: must contain exactly one .onnx and one .json file.');
    }

    // Derive a stable ID from the .onnx filename (sanitised).
    final voiceId = p
        .basenameWithoutExtension(onnxEntry.name)
        .toLowerCase()
        .replaceAll(RegExp(r'[^a-z0-9_]'), '_');

    final voiceDir = await _voiceDirectory(voiceId);

    final onnxPath = p.join(voiceDir, '${voiceId}.onnx');
    final jsonPath = p.join(voiceDir, '${voiceId}.json');

    await File(onnxPath).writeAsBytes(onnxEntry.content as List<int>);
    await File(jsonPath).writeAsBytes(jsonEntry.content as List<int>);

    final newVoice = VoiceModel(
      id: voiceId,
      displayName: _humanise(voiceId),
      language: 'unknown',
      flagEmoji: '🌐',
      architecture: VoiceArchitecture.vits, // default; user can override later
      onnxModelPath: onnxPath,
      configJsonPath: jsonPath,
      sizeBytes: zipFile.lengthSync(),
      status: VoiceStatus.local,
      isCustomImport: true,
    );

    await _persist(newVoice);
    _voiceListSubject.add([newVoice, ..._voiceListSubject.value]);
    return newVoice;
  }

  // ── Selection ──────────────────────────────────────────────────────────────

  @override
  Future<void> selectVoice(String voiceId) async {
    final updated = _voiceListSubject.value.map((v) {
      return v.copyWith(isSelected: v.id == voiceId);
    }).toList();

    // Persist selection flags.
    for (final v in updated) {
      await _persist(v);
    }
    _voiceListSubject.add(updated);
  }

  @override
  Future<VoiceModel?> getSelectedVoice() async {
    final dto = await _isar.voiceModelDtos
        .filter()
        .isSelectedEqualTo(true)
        .findFirst();
    return dto?.toDomain();
  }

  // ── Deletion ───────────────────────────────────────────────────────────────

  @override
  Future<void> deleteVoice(String voiceId) async {
    final voice = _voiceListSubject.value
        .firstWhere((v) => v.id == voiceId, orElse: () => throw VoiceImportFailure('Not found'));

    // Delete files from disk.
    final voiceDir = await _voiceDirectory(voiceId);
    final dir = Directory(voiceDir);
    if (await dir.exists()) await dir.delete(recursive: true);

    if (voice.isCustomImport) {
      // Remove custom imports entirely from DB.
      await _isar.writeTxn(() async {
        await _isar.voiceModelDtos.filter().idEqualTo(voiceId).deleteAll();
      });
      _voiceListSubject.add(
        _voiceListSubject.value.where((v) => v.id != voiceId).toList(),
      );
    } else {
      // Catalogue voices revert to remote status.
      final updated = voice.copyWith(
        status: VoiceStatus.remote,
        onnxModelPath: null,
        configJsonPath: null,
        isSelected: false,
      );
      await _persist(updated);
      _updateVoiceInList(updated);
    }
  }

  // ── Internal helpers ───────────────────────────────────────────────────────

  Future<String> _voiceDirectory(String voiceId) async {
    final base = await getApplicationDocumentsDirectory();
    final dir = Directory(p.join(base.path, 'voices', voiceId));
    await dir.create(recursive: true);
    return dir.path;
  }

  Future<void> _extractZip({
    required List<int> zipBytes,
    required String targetDir,
    required String voiceId,
  }) async {
    final archive = ZipDecoder().decodeBytes(zipBytes);
    for (final file in archive.files) {
      if (!file.isFile) continue;
      final outPath = p.join(targetDir, p.basename(file.name));
      await File(outPath).writeAsBytes(file.content as List<int>);
    }
  }

  String _findFileInDir(String dirPath, String extension) {
    final dir = Directory(dirPath);
    return dir
        .listSync()
        .whereType<File>()
        .firstWhere((f) => f.path.endsWith(extension),
        orElse: () => throw VoiceImportFailure(
            'No $extension file found in $dirPath'))
        .path;
  }

  Future<void> _persist(VoiceModel model) async {
    await _isar.writeTxn(() async {
      await _isar.voiceModelDtos.put(VoiceModelDto.fromDomain(model));
    });
  }

  void _updateVoiceInList(VoiceModel updated) {
    final list = _voiceListSubject.value.map((v) {
      return v.id == updated.id ? updated : v;
    }).toList();
    _voiceListSubject.add(list);
  }

  void _updateProgress(String voiceId,
      {double? value, bool remove = false}) {
    final map = Map<String, double>.from(_progressSubject.value);
    if (remove) {
      map.remove(voiceId);
    } else if (value != null) {
      map[voiceId] = value;
    }
    _progressSubject.add(map);
  }

  String _humanise(String id) => id
      .split('_')
      .map((w) => w.isEmpty ? '' : w[0].toUpperCase() + w.substring(1))
      .join(' ');
}

// ─────────────────────────────────────────────────────────────────────────────
// MISSING DART STDLIB EXTENSION (available in Dart 3+)
// ─────────────────────────────────────────────────────────────────────────────
extension _FirstOrNull<T> on Iterable<T> {
  T? get firstOrNull => isEmpty ? null : first;
}