import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
// WAŻNE: Tu musi być import Twojego modelu głosu (DTO)
import '../../../features/tts_player/data/models/voice_model_dto.dart';

part 'isar_provider.g.dart';

@riverpod
Future<Isar> isar(IsarRef ref) async {
  // Pobieramy folder, w którym aplikacja może legalnie zapisywać dane
  final dir = await getApplicationDocumentsDirectory();

  // Otwieramy bazę z zarejestrowanym schematem VoiceModelDto
  return Isar.open(
    [VoiceModelDtoSchema],
    directory: dir.path,
  );
}