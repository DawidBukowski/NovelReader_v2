// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'library_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$savedArticlesHash() => r'b21880e9f2d84a3cedfbaa821a91a96284880c2d';

/// See also [savedArticles].
@ProviderFor(savedArticles)
final savedArticlesProvider =
    AutoDisposeFutureProvider<List<SavedArticleDto>>.internal(
  savedArticles,
  name: r'savedArticlesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$savedArticlesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef SavedArticlesRef = AutoDisposeFutureProviderRef<List<SavedArticleDto>>;
String _$updateProgressHash() => r'f7c9cacdb776dfc76e12b77b0d8ebff6e542b651';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [updateProgress].
@ProviderFor(updateProgress)
const updateProgressProvider = UpdateProgressFamily();

/// See also [updateProgress].
class UpdateProgressFamily extends Family<AsyncValue<void>> {
  /// See also [updateProgress].
  const UpdateProgressFamily();

  /// See also [updateProgress].
  UpdateProgressProvider call({
    required int articleId,
    required int segmentIndex,
  }) {
    return UpdateProgressProvider(
      articleId: articleId,
      segmentIndex: segmentIndex,
    );
  }

  @override
  UpdateProgressProvider getProviderOverride(
    covariant UpdateProgressProvider provider,
  ) {
    return call(
      articleId: provider.articleId,
      segmentIndex: provider.segmentIndex,
    );
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'updateProgressProvider';
}

/// See also [updateProgress].
class UpdateProgressProvider extends AutoDisposeFutureProvider<void> {
  /// See also [updateProgress].
  UpdateProgressProvider({
    required int articleId,
    required int segmentIndex,
  }) : this._internal(
          (ref) => updateProgress(
            ref as UpdateProgressRef,
            articleId: articleId,
            segmentIndex: segmentIndex,
          ),
          from: updateProgressProvider,
          name: r'updateProgressProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$updateProgressHash,
          dependencies: UpdateProgressFamily._dependencies,
          allTransitiveDependencies:
              UpdateProgressFamily._allTransitiveDependencies,
          articleId: articleId,
          segmentIndex: segmentIndex,
        );

  UpdateProgressProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.articleId,
    required this.segmentIndex,
  }) : super.internal();

  final int articleId;
  final int segmentIndex;

  @override
  Override overrideWith(
    FutureOr<void> Function(UpdateProgressRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: UpdateProgressProvider._internal(
        (ref) => create(ref as UpdateProgressRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        articleId: articleId,
        segmentIndex: segmentIndex,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<void> createElement() {
    return _UpdateProgressProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is UpdateProgressProvider &&
        other.articleId == articleId &&
        other.segmentIndex == segmentIndex;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, articleId.hashCode);
    hash = _SystemHash.combine(hash, segmentIndex.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin UpdateProgressRef on AutoDisposeFutureProviderRef<void> {
  /// The parameter `articleId` of this provider.
  int get articleId;

  /// The parameter `segmentIndex` of this provider.
  int get segmentIndex;
}

class _UpdateProgressProviderElement
    extends AutoDisposeFutureProviderElement<void> with UpdateProgressRef {
  _UpdateProgressProviderElement(super.provider);

  @override
  int get articleId => (origin as UpdateProgressProvider).articleId;
  @override
  int get segmentIndex => (origin as UpdateProgressProvider).segmentIndex;
}

String _$articleSaverHash() => r'44f7fd9b910f113a68f4a550cb9af76f126c220c';

/// See also [ArticleSaver].
@ProviderFor(ArticleSaver)
final articleSaverProvider =
    AutoDisposeNotifierProvider<ArticleSaver, AsyncValue<void>>.internal(
  ArticleSaver.new,
  name: r'articleSaverProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$articleSaverHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ArticleSaver = AutoDisposeNotifier<AsyncValue<void>>;
String _$articleDeleterHash() => r'd58dc9b32a6a80a306ccc8bf3b3eecf107b0b941';

/// See also [ArticleDeleter].
@ProviderFor(ArticleDeleter)
final articleDeleterProvider =
    AutoDisposeNotifierProvider<ArticleDeleter, AsyncValue<void>>.internal(
  ArticleDeleter.new,
  name: r'articleDeleterProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$articleDeleterHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$ArticleDeleter = AutoDisposeNotifier<AsyncValue<void>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
