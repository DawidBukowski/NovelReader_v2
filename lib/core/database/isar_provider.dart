// lib/core/database/isar_provider.dart
//
// Single Isar instance shared across the entire app.
// keepAlive: true — never disposed, lives for the full app lifetime.
// =============================================================================

import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../features/tts_player/data/models/voice_model_dto.dart';

part 'isar_provider.g.dart';

@Riverpod(keepAlive: true)
Future<Isar> isar(IsarRef ref) async {
  final dir = await getApplicationDocumentsDirectory();

  return Isar.open(
    [
      VoiceModelDtoSchema,
      //SavedArticleDtoSchema,
    ],
    directory: dir.path,
    name: 'open_reader_db',
  );
}