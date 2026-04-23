/// Typed failure hierarchy — returned in Either<Failure, T> from repositories.
sealed class Failure {
  const Failure(this.message);
  final String message;
}

class NetworkFailure extends Failure {
  const NetworkFailure(super.message);
}

class DatabaseFailure extends Failure {
  const DatabaseFailure(super.message);
}

class TtsFailure extends Failure {
  const TtsFailure(super.message);
}

class VoiceImportFailure extends Failure {
  const VoiceImportFailure(super.message);
}

class ScraperFailure extends Failure {
  const ScraperFailure(super.message);
}
