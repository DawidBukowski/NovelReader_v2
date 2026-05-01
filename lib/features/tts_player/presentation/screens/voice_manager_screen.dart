// lib/features/tts_player/presentation/screens/voice_manager_screen.dart
// =============================================================================

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/voice_model.dart';
import '../providers/tts_providers.dart';

class VoiceManagerScreen extends ConsumerWidget {
  const VoiceManagerScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final voicesAsync = ref.watch(voiceListProvider);
    final progressAsync = ref.watch(downloadProgressProvider);

    final progressMap = progressAsync.valueOrNull ?? {};

    return Scaffold(
      appBar: AppBar(
        title: const Text('Voice Manager'),
        actions: [
          IconButton(
            icon: const Icon(Icons.folder_zip_outlined),
            tooltip: 'Import voice zip',
            onPressed: () => _importZip(context, ref),
          ),
        ],
      ),
      body: voicesAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (voices) {
          final local =
          voices.where((v) => v.status == VoiceStatus.local).toList();
          final remote =
          voices.where((v) => v.status != VoiceStatus.local).toList();

          return ListView(
            padding: const EdgeInsets.only(bottom: 32),
            children: [
              if (local.isNotEmpty) ...[
                _SectionHeader(
                    title: 'Downloaded (${local.length})'),
                ...local.map((v) => _VoiceTile(
                  voice: v,
                  progress: progressMap[v.id],
                )),
              ],
              _SectionHeader(
                  title: 'Available to Download (${remote.length})'),
              ...remote.map((v) => _VoiceTile(
                voice: v,
                progress: progressMap[v.id],
              )),
            ],
          );
        },
      ),
    );
  }

  Future<void> _importZip(BuildContext context, WidgetRef ref) async {
    final result = await FilePicker.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['zip'],
    );
    if (result == null || result.files.single.path == null) return;

    try {
      final useCase =
      await ref.read(importVoiceFromZipUseCaseProvider.future);
      await useCase(result.files.single.path!);
      ref.invalidate(voiceListProvider);
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Voice imported successfully')),
        );
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Import failed: $e'),
            backgroundColor: Theme.of(context).colorScheme.error,
          ),
        );
      }
    }
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// VOICE TILE
// ─────────────────────────────────────────────────────────────────────────────

class _VoiceTile extends ConsumerWidget {
  const _VoiceTile({required this.voice, this.progress});
  final VoiceModel voice;
  final double? progress;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final isDownloading = voice.status == VoiceStatus.downloading ||
        progress != null;
    final isLocal = voice.status == VoiceStatus.local;

    return ListTile(
      leading: CircleAvatar(
        backgroundColor: theme.colorScheme.primaryContainer,
        child: Text(
          voice.flagEmoji,
          style: const TextStyle(fontSize: 20),
        ),
      ),
      title: Text(
        voice.displayName,
        style: const TextStyle(fontWeight: FontWeight.w600),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '${voice.language} · ${voice.architecture.name.toUpperCase()}'
                ' · ${_formatSize(voice.sizeBytes)}',
            style: theme.textTheme.bodySmall,
          ),
          if (isDownloading && progress != null) ...[
            const SizedBox(height: 6),
            LinearProgressIndicator(
              value: progress,
              borderRadius: BorderRadius.circular(2),
            ),
            Text(
              '${(progress! * 100).round()}%',
              style: theme.textTheme.labelSmall,
            ),
          ],
          // Quality stars
          Row(
            children: List.generate(5, (i) => Icon(
              i < voice.qualityRating
                  ? Icons.star_rounded
                  : Icons.star_outline_rounded,
              size: 14,
              color: theme.colorScheme.primary,
            )),
          ),
        ],
      ),
      isThreeLine: true,
      trailing: _TrailingAction(
        voice: voice,
        progress: progress,
        isDownloading: isDownloading,
        isLocal: isLocal,
      ),
      // Tap to select (only if local)
      onTap: isLocal
          ? () async {
        final uc =
        await ref.read(selectVoiceUseCaseProvider.future);
        await uc(voice.id);
        ref.invalidate(voiceListProvider);
        ref.invalidate(selectedVoiceProvider);
      }
          : null,
    );
  }

  String _formatSize(int bytes) {
    if (bytes < 1024 * 1024) return '${(bytes / 1024).round()} KB';
    return '${(bytes / (1024 * 1024)).toStringAsFixed(1)} MB';
  }
}

class _TrailingAction extends ConsumerWidget {
  const _TrailingAction({
    required this.voice,
    required this.progress,
    required this.isDownloading,
    required this.isLocal,
  });

  final VoiceModel voice;
  final double? progress;
  final bool isDownloading;
  final bool isLocal;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);

    if (voice.isSelected) {
      return Icon(Icons.check_circle_rounded,
          color: theme.colorScheme.primary);
    }

    if (isDownloading) {
      return IconButton(
        icon: const Icon(Icons.cancel_outlined),
        onPressed: () async {
          final repo =
          await ref.read(voiceRepositoryProvider.future);
          await repo.cancelDownload(voice.id);
          ref.invalidate(voiceListProvider);
        },
      );
    }

    if (isLocal) {
      return PopupMenuButton<String>(
        itemBuilder: (_) => [
          const PopupMenuItem(value: 'select', child: Text('Use this voice')),
          const PopupMenuItem(
              value: 'delete',
              child: Text('Delete', style: TextStyle(color: Colors.red))),
        ],
        onSelected: (action) async {
          if (action == 'select') {
            final uc =
            await ref.read(selectVoiceUseCaseProvider.future);
            await uc(voice.id);
            ref.invalidate(voiceListProvider);
            ref.invalidate(selectedVoiceProvider);
          } else if (action == 'delete') {
            final uc =
            await ref.read(deleteVoiceUseCaseProvider.future);
            await uc(voice.id);
            ref.invalidate(voiceListProvider);
          }
        },
      );
    }

    // Remote — show download button
    return IconButton(
      icon: const Icon(Icons.download_rounded),
      onPressed: () async {
        final uc =
        await ref.read(downloadVoiceUseCaseProvider.future);
        await uc(voice.id);
        ref.invalidate(voiceListProvider);
      },
    );
  }
}

// ─────────────────────────────────────────────────────────────────────────────
// SECTION HEADER
// ─────────────────────────────────────────────────────────────────────────────

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title});
  final String title;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 20, 16, 6),
      child: Text(
        title.toUpperCase(),
        style: theme.textTheme.labelSmall?.copyWith(
          color: theme.colorScheme.onSurfaceVariant,
          fontWeight: FontWeight.w700,
          letterSpacing: 1.2,
        ),
      ),
    );
  }
}