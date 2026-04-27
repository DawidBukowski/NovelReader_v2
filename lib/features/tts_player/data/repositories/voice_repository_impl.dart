// lib/features/tts_player/data/repositories/voice_repository_impl.dart

import 'dart:async';
import 'dart:convert';
import 'dart:io';

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

const String kVoiceCatalogueUrl =
    'https://raw.githubusercontent.com/your-org/open-reader-voices/main/catalogue.json';

class VoiceRepositoryImpl implements VoiceRepository {
  VoiceRepositoryImpl({required Isar isar}) : _isar = isar;

  final Isar _isar;

  final BehaviorSubject<List<VoiceModel>> _voiceListSubject =
  BehaviorSubject.seeded([]);
  final BehaviorSubject<Map<String, double>> _progressSubject =
  BehaviorSubject.seeded({});

  final Map<String, bool> _cancelledDownloads = {};

  @override
  Stream<List<VoiceModel>> get voiceListStream => _voiceListSubject.stream;

  @override
  Stream<Map<String, double>> get downloadProgressStream =>
      _progressSubject.stream;

  // ── Catalogue ──────────────────────────────────────────────────────────────

  @override
  Future<List<VoiceModel>> getAvailableVoices() async {
    final localDtos = await _isar.voiceModelDtos.where().findAll();
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
            .where((v) => !localMap.containsKey(v.id))
            .toList();
      }
    } on Exception {
      // Offline — fall back to local list silently.
    }

    final merged = [
      ...localMap.values,
      ...remoteVoices,
    ]..sort((a, b) {
      if (a.isSelected) return -1;
      if (b.isSelected) return 1;
      if (a.status == VoiceStatus.local && b.status != VoiceStatus.local) {
        return -1;
      }
      if (b.status == VoiceStatus.local && a.status != VoiceStatus.local) {
        return 1;
      }
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

      final request = http.Request('GET', Uri.parse(voice.remoteZipUrl!));
      final streamedResponse = await http.Client().send(request);

      final totalBytes =
          streamedResponse.contentLength ?? voice.sizeBytes;
      var receivedBytes = 0;
      final chunks = <List<int>>[];

      await for (final chunk in streamedResponse.stream) {
        if (_cancelledDownloads[voiceId] == true) {
          _updateVoiceInList(voice.copyWith(status: VoiceStatus.remote));
          _updateProgress(voiceId, remove: true);
          return;
        }
        chunks.add(chunk);
        receivedBytes += chunk.length;
        _updateProgress(
          voiceId,
          value: (receivedBytes / totalBytes).clamp(0.0, 1.0),
        );
      }

      final allBytes = chunks.expand((c) => c).toList();

      // Determine archive type from URL and extract.
      final url = voice.remoteZipUrl!.toLowerCase();
      if (url.endsWith('.tar.bz2') || url.endsWith('.tbz2')) {
        await _extractTarBz2(bytes: allBytes, targetDir: voiceDir);
      } else if (url.endsWith('.tar.gz') || url.endsWith('.tgz')) {
        await _extractTarGz(bytes: allBytes, targetDir: voiceDir);
      } else {
        await _extractZip(bytes: allBytes, targetDir: voiceDir);
      }

      // Find the .onnx and .onnx.json files written to disk.
      final onnxPath = _findFile(voiceDir, '.onnx',
          exclude: '.json'); // pure .onnx, not .onnx.json
      final jsonPath = _findFile(voiceDir, '.onnx.json');

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

    // Accept either .onnx.json or plain .json
    final onnxEntry = archive.files
        .where((f) => f.isFile && f.name.endsWith('.onnx') && !f.name.endsWith('.onnx.json'))
        .firstOrNull;
    final jsonEntry = archive.files
        .where((f) => f.isFile &&
        (f.name.endsWith('.onnx.json') || f.name.endsWith('.json')))
        .firstOrNull;

    if (onnxEntry == null || jsonEntry == null) {
      throw VoiceImportFailure(
        'Invalid voice pack: must contain a .onnx model and a .json config file.',
      );
    }

    final voiceId = p
        .basenameWithoutExtension(onnxEntry.name)
        .toLowerCase()
        .replaceAll(RegExp(r'[^a-z0-9_]'), '_');

    final voiceDir = await _voiceDirectory(voiceId);
    final onnxPath = p.join(voiceDir, p.basename(onnxEntry.name));
    final jsonPath = p.join(voiceDir, p.basename(jsonEntry.name));

    await File(onnxPath)
        .writeAsBytes(onnxEntry.content as List<int>);
    await File(jsonPath)
        .writeAsBytes(jsonEntry.content as List<int>);

    final newVoice = VoiceModel(
      id: voiceId,
      displayName: _humanise(voiceId),
      language: 'unknown',
      flagEmoji: '🌐',
      architecture: VoiceArchitecture.vits,
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
    final voice = _voiceListSubject.value.firstWhere(
          (v) => v.id == voiceId,
      orElse: () =>
      throw VoiceImportFailure('Voice $voiceId not found'),
    );

    final dirPath = await _voiceDirectory(voiceId);
    final dir = Directory(dirPath);
    if (await dir.exists()) await dir.delete(recursive: true);

    if (voice.isCustomImport) {
      await _isar.writeTxn(() async {
        await _isar.voiceModelDtos.filter().idEqualTo(voiceId).deleteAll();
      });
      _voiceListSubject.add(
        _voiceListSubject.value.where((v) => v.id != voiceId).toList(),
      );
    } else {
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

  // ── Archive extraction ─────────────────────────────────────────────────────

  Future<void> _extractTarBz2({
    required List<int> bytes,
    required String targetDir,
  }) async {
    // BZip2 decompress → raw tar bytes → extract files
    final decompressed = BZip2Decoder().decodeBytes(bytes);
    final archive = TarDecoder().decodeBytes(decompressed);
    await _writeArchive(archive, targetDir);
  }

  Future<void> _extractTarGz({
    required List<int> bytes,
    required String targetDir,
  }) async {
    final decompressed = GZipDecoder().decodeBytes(bytes);
    final archive = TarDecoder().decodeBytes(decompressed);
    await _writeArchive(archive, targetDir);
  }

  Future<void> _extractZip({
    required List<int> bytes,
    required String targetDir,
  }) async {
    final archive = ZipDecoder().decodeBytes(bytes);
    await _writeArchive(archive, targetDir);
  }

  Future<void> _writeArchive(Archive archive, String targetDir) async {
    for (final file in archive.files) {
      if (!file.isFile) continue;
      // Flatten directory structure — write all files directly into targetDir.
      final filename = p.basename(file.name);
      if (filename.isEmpty) continue;
      final outPath = p.join(targetDir, filename);
      await File(outPath).writeAsBytes(file.content as List<int>);
    }
  }

  // ── File search ────────────────────────────────────────────────────────────

  /// Find first file in [dirPath] ending with [extension].
  /// [exclude] lets you skip files that ALSO end with another suffix
  /// (e.g. find ".onnx" but not ".onnx.json").
  String _findFile(String dirPath, String extension, {String? exclude}) {
    final dir = Directory(dirPath);
    final files = dir
        .listSync(recursive: true)
        .whereType<File>()
        .where((f) {
      if (!f.path.endsWith(extension)) return false;
      if (exclude != null && f.path.endsWith(exclude)) return false;
      return true;
    }).toList();

    if (files.isEmpty) {
      throw VoiceImportFailure(
        'No file with extension "$extension" found in $dirPath',
      );
    }
    return files.first.path;
  }

  // ── Helpers ────────────────────────────────────────────────────────────────

  Future<String> _voiceDirectory(String voiceId) async {
    final base = await getApplicationDocumentsDirectory();
    final dir =
    Directory(p.join(base.path, 'voices', voiceId));
    await dir.create(recursive: true);
    return dir.path;
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
      .map((w) =>
  w.isEmpty ? '' : w[0].toUpperCase() + w.substring(1))
      .join(' ');
}

extension<T> on Iterable<T> {
  T? get firstOrNull => isEmpty ? null : first;
}