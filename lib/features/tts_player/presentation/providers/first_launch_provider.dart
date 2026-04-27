// lib/features/tts_player/presentation/providers/first_launch_provider.dart
//
// Detects first launch (no voice selected) and drives the
// "Download your first voice" prompt shown on the Library screen.
// =============================================================================

import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'tts_providers.dart';

part 'first_launch_provider.g.dart';

@riverpod
Future<bool> needsFirstVoice(NeedsFirstVoiceRef ref) async {
  final selected = await ref.watch(selectedVoiceProvider.future);
  return selected == null;
}