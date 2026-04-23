// lib/features/tts_player/data/audio/audio_service_handler.dart
//
// Extends [BaseAudioHandler] from the `audio_service` package.
// Responsibilities:
//   1. Translates OS media button events (headphones, lock screen) → domain calls
//   2. Translates domain [TtsPlayerState] → [PlaybackState] for the OS
//   3. Drives [just_audio] for actual audio output
//
// This class is intentionally thin. ALL business logic lives in
// [TtsRepositoryImpl]. This handler is a pure adapter.
// =============================================================================

import 'dart:async';

import 'package:audio_service/audio_service.dart';
import 'package:just_audio/just_audio.dart';

import '../../domain/entities/player_state.dart';

class OpenReaderAudioHandler extends BaseAudioHandler {
  OpenReaderAudioHandler() {
    // Set up just_audio player event forwarding.
    _player.playbackEventStream.listen(_onPlaybackEvent);
    _player.playerStateStream.listen(_onPlayerStateChanged);
  }

  final AudioPlayer _player = AudioPlayer();

  // Injected callbacks — set by TtsRepositoryImpl after construction.
  // Using callbacks avoids a circular dependency between the handler and repo.
  VoidCallback? onSkipNext;
  VoidCallback? onSkipPrevious;
  VoidCallback? onPlayCompleted;

  Duration get currentPosition => _player.position;

  // ── Playback ───────────────────────────────────────────────────────────────

  /// Load and play a WAV file at [filePath].
  Future<void> playFile(String filePath) async {
    await _player.setFilePath(filePath);
    await _player.play();
  }

  @override
  Future<void> play() async => _player.play();

  @override
  Future<void> pause() async => _player.pause();

  @override
  Future<void> stop() async {
    await _player.stop();
    await _player.seek(Duration.zero);
  }

  @override
  Future<void> skipToNext() async => onSkipNext?.call();

  @override
  Future<void> skipToPrevious() async => onSkipPrevious?.call();

  // ── Metadata ───────────────────────────────────────────────────────────────

  /// Call this when a new article is loaded to update the lock screen card.
  void updateMediaItem({required String title, required String artist}) {
    mediaItem.add(MediaItem(
      id: 'open_reader_current',
      title: title,
      artist: artist,
      album: 'OpenReader',
      playable: true,
    ));
  }

  // ── State sync ─────────────────────────────────────────────────────────────

  /// Called by [TtsRepositoryImpl] every time [TtsPlayerState] changes.
  /// Translates domain state → [PlaybackState] so the OS notification and
  /// lock screen stay in sync.
  void syncPlaybackState(TtsPlayerState domainState) {
    final isPlaying = domainState.status == TtsPlaybackStatus.playing;
    final isLoading = domainState.status == TtsPlaybackStatus.loading;

    playbackState.add(PlaybackState(
      controls: [
        MediaControl.skipToPrevious,
        isPlaying ? MediaControl.pause : MediaControl.play,
        MediaControl.skipToNext,
      ],
      systemActions: const {
        MediaAction.seek,
        MediaAction.skipToNext,
        MediaAction.skipToPrevious,
      },
      androidCompactActionIndices: const [0, 1, 2],
      processingState: isLoading
          ? AudioProcessingState.loading
          : AudioProcessingState.ready,
      playing: isPlaying,
      updatePosition: _player.position,
      bufferedPosition: _player.bufferedPosition,
      speed: domainState.speed,
    ));
  }

  // ── just_audio event forwarding ────────────────────────────────────────────

  void _onPlaybackEvent(PlaybackEvent event) {
    // Keep buffered position updated on the lock screen.
    playbackState.add(playbackState.value.copyWith(
      bufferedPosition: _player.bufferedPosition,
    ));
  }

  void _onPlayerStateChanged(PlayerState state) {
    if (state.processingState == ProcessingState.completed) {
      // The WAV for one segment finished — notify the repo to advance.
      onPlayCompleted?.call();
    }
  }

  // ── Cleanup ────────────────────────────────────────────────────────────────

  Future<void> disposePlayer() async {
    await _player.dispose();
  }
}

typedef VoidCallback = void Function();