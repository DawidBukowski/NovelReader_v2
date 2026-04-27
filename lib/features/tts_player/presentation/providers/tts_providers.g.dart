// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tts_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$sherpaOnnxServiceHash() => r'41137affc6c2a3be42275d8ba1692c99efa4ddf7';

/// See also [sherpaOnnxService].
@ProviderFor(sherpaOnnxService)
final sherpaOnnxServiceProvider = Provider<SherpaOnnxService>.internal(
  sherpaOnnxService,
  name: r'sherpaOnnxServiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$sherpaOnnxServiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef SherpaOnnxServiceRef = ProviderRef<SherpaOnnxService>;
String _$voiceRepositoryHash() => r'02b30fa41ad148f5511e77ac45ad778d4500f716';

/// See also [voiceRepository].
@ProviderFor(voiceRepository)
final voiceRepositoryProvider = FutureProvider<VoiceRepository>.internal(
  voiceRepository,
  name: r'voiceRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$voiceRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef VoiceRepositoryRef = FutureProviderRef<VoiceRepository>;
String _$ttsRepositoryHash() => r'0ccba1da8d681257e7d0ad24276235c57d889cff';

/// See also [ttsRepository].
@ProviderFor(ttsRepository)
final ttsRepositoryProvider = FutureProvider<TtsRepository>.internal(
  ttsRepository,
  name: r'ttsRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$ttsRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef TtsRepositoryRef = FutureProviderRef<TtsRepository>;
String _$playerStateHash() => r'1dba23e1d71f249ef6c8972aa67432ba2f2a3386';

/// See also [playerState].
@ProviderFor(playerState)
final playerStateProvider = AutoDisposeStreamProvider<TtsPlayerState>.internal(
  playerState,
  name: r'playerStateProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$playerStateHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef PlayerStateRef = AutoDisposeStreamProviderRef<TtsPlayerState>;
String _$selectedVoiceHash() => r'bf450428a6f0243accc5376ca0063f96bb5228a1';

/// See also [selectedVoice].
@ProviderFor(selectedVoice)
final selectedVoiceProvider = AutoDisposeFutureProvider<VoiceModel?>.internal(
  selectedVoice,
  name: r'selectedVoiceProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$selectedVoiceHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef SelectedVoiceRef = AutoDisposeFutureProviderRef<VoiceModel?>;
String _$voiceListHash() => r'87cf11f1d39808e162c41b94d23a538c97adce1b';

/// See also [voiceList].
@ProviderFor(voiceList)
final voiceListProvider = AutoDisposeFutureProvider<List<VoiceModel>>.internal(
  voiceList,
  name: r'voiceListProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$voiceListHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef VoiceListRef = AutoDisposeFutureProviderRef<List<VoiceModel>>;
String _$downloadProgressHash() => r'dd2169ec85ec9134a005cb0bd0d47a94025b95e6';

/// See also [downloadProgress].
@ProviderFor(downloadProgress)
final downloadProgressProvider =
    AutoDisposeStreamProvider<Map<String, double>>.internal(
  downloadProgress,
  name: r'downloadProgressProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$downloadProgressHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef DownloadProgressRef = AutoDisposeStreamProviderRef<Map<String, double>>;
String _$loadArticleUseCaseHash() =>
    r'43ad2aef44b6ed35262a3b8a94deeaee56f316aa';

/// See also [loadArticleUseCase].
@ProviderFor(loadArticleUseCase)
final loadArticleUseCaseProvider =
    AutoDisposeFutureProvider<LoadArticleUseCase>.internal(
  loadArticleUseCase,
  name: r'loadArticleUseCaseProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$loadArticleUseCaseHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef LoadArticleUseCaseRef
    = AutoDisposeFutureProviderRef<LoadArticleUseCase>;
String _$playUseCaseHash() => r'93fefc94749257b8c55f2154c0759600c606aaf4';

/// See also [playUseCase].
@ProviderFor(playUseCase)
final playUseCaseProvider = AutoDisposeFutureProvider<PlayUseCase>.internal(
  playUseCase,
  name: r'playUseCaseProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$playUseCaseHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef PlayUseCaseRef = AutoDisposeFutureProviderRef<PlayUseCase>;
String _$pauseUseCaseHash() => r'ec0a742a38f75fec4588705e79eb1ebe8720be27';

/// See also [pauseUseCase].
@ProviderFor(pauseUseCase)
final pauseUseCaseProvider = AutoDisposeFutureProvider<PauseUseCase>.internal(
  pauseUseCase,
  name: r'pauseUseCaseProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$pauseUseCaseHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef PauseUseCaseRef = AutoDisposeFutureProviderRef<PauseUseCase>;
String _$skipNextUseCaseHash() => r'75354b7559bbae46032bc52f1996af2b8efd3c28';

/// See also [skipNextUseCase].
@ProviderFor(skipNextUseCase)
final skipNextUseCaseProvider =
    AutoDisposeFutureProvider<SkipNextUseCase>.internal(
  skipNextUseCase,
  name: r'skipNextUseCaseProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$skipNextUseCaseHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef SkipNextUseCaseRef = AutoDisposeFutureProviderRef<SkipNextUseCase>;
String _$skipPreviousUseCaseHash() =>
    r'b70f0d46c984836105446476c728c85fc9277131';

/// See also [skipPreviousUseCase].
@ProviderFor(skipPreviousUseCase)
final skipPreviousUseCaseProvider =
    AutoDisposeFutureProvider<SkipPreviousUseCase>.internal(
  skipPreviousUseCase,
  name: r'skipPreviousUseCaseProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$skipPreviousUseCaseHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef SkipPreviousUseCaseRef
    = AutoDisposeFutureProviderRef<SkipPreviousUseCase>;
String _$seekToSegmentUseCaseHash() =>
    r'0b9165a402c5cb8099060b9ae7f24f731ec2d63a';

/// See also [seekToSegmentUseCase].
@ProviderFor(seekToSegmentUseCase)
final seekToSegmentUseCaseProvider =
    AutoDisposeFutureProvider<SeekToSegmentUseCase>.internal(
  seekToSegmentUseCase,
  name: r'seekToSegmentUseCaseProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$seekToSegmentUseCaseHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef SeekToSegmentUseCaseRef
    = AutoDisposeFutureProviderRef<SeekToSegmentUseCase>;
String _$setSpeedUseCaseHash() => r'0976ae5e1ce61e5173b4f7deb91a109c1ccf2cfe';

/// See also [setSpeedUseCase].
@ProviderFor(setSpeedUseCase)
final setSpeedUseCaseProvider =
    AutoDisposeFutureProvider<SetSpeedUseCase>.internal(
  setSpeedUseCase,
  name: r'setSpeedUseCaseProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$setSpeedUseCaseHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef SetSpeedUseCaseRef = AutoDisposeFutureProviderRef<SetSpeedUseCase>;
String _$downloadVoiceUseCaseHash() =>
    r'70412c57d8da8ea3733779b9a63c9fb88f37ab69';

/// See also [downloadVoiceUseCase].
@ProviderFor(downloadVoiceUseCase)
final downloadVoiceUseCaseProvider =
    AutoDisposeFutureProvider<DownloadVoiceUseCase>.internal(
  downloadVoiceUseCase,
  name: r'downloadVoiceUseCaseProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$downloadVoiceUseCaseHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef DownloadVoiceUseCaseRef
    = AutoDisposeFutureProviderRef<DownloadVoiceUseCase>;
String _$importVoiceFromZipUseCaseHash() =>
    r'de7ace61ae6e2c2eb8b626084ecb226db6ceebdc';

/// See also [importVoiceFromZipUseCase].
@ProviderFor(importVoiceFromZipUseCase)
final importVoiceFromZipUseCaseProvider =
    AutoDisposeFutureProvider<ImportVoiceFromZipUseCase>.internal(
  importVoiceFromZipUseCase,
  name: r'importVoiceFromZipUseCaseProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$importVoiceFromZipUseCaseHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef ImportVoiceFromZipUseCaseRef
    = AutoDisposeFutureProviderRef<ImportVoiceFromZipUseCase>;
String _$selectVoiceUseCaseHash() =>
    r'c8b9ed9645013828501d5a3210625cea44db411a';

/// See also [selectVoiceUseCase].
@ProviderFor(selectVoiceUseCase)
final selectVoiceUseCaseProvider =
    AutoDisposeFutureProvider<SelectVoiceUseCase>.internal(
  selectVoiceUseCase,
  name: r'selectVoiceUseCaseProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$selectVoiceUseCaseHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef SelectVoiceUseCaseRef
    = AutoDisposeFutureProviderRef<SelectVoiceUseCase>;
String _$deleteVoiceUseCaseHash() =>
    r'b8876767294b3a91b6dbd3062574e61a00597871';

/// See also [deleteVoiceUseCase].
@ProviderFor(deleteVoiceUseCase)
final deleteVoiceUseCaseProvider =
    AutoDisposeFutureProvider<DeleteVoiceUseCase>.internal(
  deleteVoiceUseCase,
  name: r'deleteVoiceUseCaseProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$deleteVoiceUseCaseHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef DeleteVoiceUseCaseRef
    = AutoDisposeFutureProviderRef<DeleteVoiceUseCase>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
