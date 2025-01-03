// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'riverpod_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$getTrendingProductsHash() =>
    r'8083e266969dc0aec36af1b4d1d1fd9a13b0c57f';

/// See also [getTrendingProducts].
@ProviderFor(getTrendingProducts)
final getTrendingProductsProvider =
    AutoDisposeFutureProvider<List<ProductModel>>.internal(
  getTrendingProducts,
  name: r'getTrendingProductsProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$getTrendingProductsHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef GetTrendingProductsRef
    = AutoDisposeFutureProviderRef<List<ProductModel>>;
String _$getCategoryProductsHash() =>
    r'304132aba44fee0eee424666b0aaef82d226ce2b';

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

/// See also [getCategoryProducts].
@ProviderFor(getCategoryProducts)
const getCategoryProductsProvider = GetCategoryProductsFamily();

/// See also [getCategoryProducts].
class GetCategoryProductsFamily extends Family<AsyncValue<List<ProductModel>>> {
  /// See also [getCategoryProducts].
  const GetCategoryProductsFamily();

  /// See also [getCategoryProducts].
  GetCategoryProductsProvider call(
    String category,
  ) {
    return GetCategoryProductsProvider(
      category,
    );
  }

  @override
  GetCategoryProductsProvider getProviderOverride(
    covariant GetCategoryProductsProvider provider,
  ) {
    return call(
      provider.category,
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
  String? get name => r'getCategoryProductsProvider';
}

/// See also [getCategoryProducts].
class GetCategoryProductsProvider
    extends AutoDisposeFutureProvider<List<ProductModel>> {
  /// See also [getCategoryProducts].
  GetCategoryProductsProvider(
    String category,
  ) : this._internal(
          (ref) => getCategoryProducts(
            ref as GetCategoryProductsRef,
            category,
          ),
          from: getCategoryProductsProvider,
          name: r'getCategoryProductsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$getCategoryProductsHash,
          dependencies: GetCategoryProductsFamily._dependencies,
          allTransitiveDependencies:
              GetCategoryProductsFamily._allTransitiveDependencies,
          category: category,
        );

  GetCategoryProductsProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.category,
  }) : super.internal();

  final String category;

  @override
  Override overrideWith(
    FutureOr<List<ProductModel>> Function(GetCategoryProductsRef provider)
        create,
  ) {
    return ProviderOverride(
      origin: this,
      override: GetCategoryProductsProvider._internal(
        (ref) => create(ref as GetCategoryProductsRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        category: category,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<ProductModel>> createElement() {
    return _GetCategoryProductsProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is GetCategoryProductsProvider && other.category == category;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, category.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin GetCategoryProductsRef
    on AutoDisposeFutureProviderRef<List<ProductModel>> {
  /// The parameter `category` of this provider.
  String get category;
}

class _GetCategoryProductsProviderElement
    extends AutoDisposeFutureProviderElement<List<ProductModel>>
    with GetCategoryProductsRef {
  _GetCategoryProductsProviderElement(super.provider);

  @override
  String get category => (origin as GetCategoryProductsProvider).category;
}

String _$orderNotifierHash() => r'cfb0616ee03bb1590a0076fdc2c88bd9440fb6ed';

/// See also [OrderNotifier].
@ProviderFor(OrderNotifier)
final orderNotifierProvider =
    AutoDisposeAsyncNotifierProvider<OrderNotifier, List<OrderModel>>.internal(
  OrderNotifier.new,
  name: r'orderNotifierProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$orderNotifierHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$OrderNotifier = AutoDisposeAsyncNotifier<List<OrderModel>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
