// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'library_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$libraryRepositoryHash() => r'866b25d840bb169f12e5a9bca19b313a34897b56';

/// See also [libraryRepository].
@ProviderFor(libraryRepository)
final libraryRepositoryProvider =
    AutoDisposeFutureProvider<LibraryRepository>.internal(
  libraryRepository,
  name: r'libraryRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$libraryRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef LibraryRepositoryRef = AutoDisposeFutureProviderRef<LibraryRepository>;
String _$savedArticlesHash() => r'2a7aad1e025ca7ba73de02899949d1fb29d809a5';

/// See also [savedArticles].
@ProviderFor(savedArticles)
final savedArticlesProvider =
    AutoDisposeFutureProvider<List<SavedArticle>>.internal(
  savedArticles,
  name: r'savedArticlesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$savedArticlesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef SavedArticlesRef = AutoDisposeFutureProviderRef<List<SavedArticle>>;
String _$articleByIdHash() => r'83f59c46ad04f61fe2402d627d4fc744375fd576';

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

/// See also [articleById].
@ProviderFor(articleById)
const articleByIdProvider = ArticleByIdFamily();

/// See also [articleById].
class ArticleByIdFamily extends Family<AsyncValue<SavedArticle?>> {
  /// See also [articleById].
  const ArticleByIdFamily();

  /// See also [articleById].
  ArticleByIdProvider call(
    int id,
  ) {
    return ArticleByIdProvider(
      id,
    );
  }

  @override
  ArticleByIdProvider getProviderOverride(
    covariant ArticleByIdProvider provider,
  ) {
    return call(
      provider.id,
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
  String? get name => r'articleByIdProvider';
}

/// See also [articleById].
class ArticleByIdProvider extends AutoDisposeFutureProvider<SavedArticle?> {
  /// See also [articleById].
  ArticleByIdProvider(
    int id,
  ) : this._internal(
          (ref) => articleById(
            ref as ArticleByIdRef,
            id,
          ),
          from: articleByIdProvider,
          name: r'articleByIdProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$articleByIdHash,
          dependencies: ArticleByIdFamily._dependencies,
          allTransitiveDependencies:
              ArticleByIdFamily._allTransitiveDependencies,
          id: id,
        );

  ArticleByIdProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.id,
  }) : super.internal();

  final int id;

  @override
  Override overrideWith(
    FutureOr<SavedArticle?> Function(ArticleByIdRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ArticleByIdProvider._internal(
        (ref) => create(ref as ArticleByIdRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        id: id,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<SavedArticle?> createElement() {
    return _ArticleByIdProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ArticleByIdProvider && other.id == id;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, id.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin ArticleByIdRef on AutoDisposeFutureProviderRef<SavedArticle?> {
  /// The parameter `id` of this provider.
  int get id;
}

class _ArticleByIdProviderElement
    extends AutoDisposeFutureProviderElement<SavedArticle?>
    with ArticleByIdRef {
  _ArticleByIdProviderElement(super.provider);

  @override
  int get id => (origin as ArticleByIdProvider).id;
}

String _$deleteArticleUseCaseHash() =>
    r'81ef8414bd519354afb440a69e3b5d66aeba01ab';

/// See also [DeleteArticleUseCase].
@ProviderFor(DeleteArticleUseCase)
final deleteArticleUseCaseProvider =
    AutoDisposeNotifierProvider<DeleteArticleUseCase, void>.internal(
  DeleteArticleUseCase.new,
  name: r'deleteArticleUseCaseProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$deleteArticleUseCaseHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$DeleteArticleUseCase = AutoDisposeNotifier<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
