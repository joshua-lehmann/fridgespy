// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'food_repo_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$foodRepoProductHash() => r'80a3bfc3aa7e41b825751db6937f1cd7d12f471c';

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

/// See also [foodRepoProduct].
@ProviderFor(foodRepoProduct)
const foodRepoProductProvider = FoodRepoProductFamily();

/// See also [foodRepoProduct].
class FoodRepoProductFamily extends Family<AsyncValue<FoodRepoProduct?>> {
  /// See also [foodRepoProduct].
  const FoodRepoProductFamily();

  /// See also [foodRepoProduct].
  FoodRepoProductProvider call(
    String? barcode,
  ) {
    return FoodRepoProductProvider(
      barcode,
    );
  }

  @override
  FoodRepoProductProvider getProviderOverride(
    covariant FoodRepoProductProvider provider,
  ) {
    return call(
      provider.barcode,
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
  String? get name => r'foodRepoProductProvider';
}

/// See also [foodRepoProduct].
class FoodRepoProductProvider
    extends AutoDisposeFutureProvider<FoodRepoProduct?> {
  /// See also [foodRepoProduct].
  FoodRepoProductProvider(
    String? barcode,
  ) : this._internal(
          (ref) => foodRepoProduct(
            ref as FoodRepoProductRef,
            barcode,
          ),
          from: foodRepoProductProvider,
          name: r'foodRepoProductProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$foodRepoProductHash,
          dependencies: FoodRepoProductFamily._dependencies,
          allTransitiveDependencies:
              FoodRepoProductFamily._allTransitiveDependencies,
          barcode: barcode,
        );

  FoodRepoProductProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.barcode,
  }) : super.internal();

  final String? barcode;

  @override
  Override overrideWith(
    FutureOr<FoodRepoProduct?> Function(FoodRepoProductRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: FoodRepoProductProvider._internal(
        (ref) => create(ref as FoodRepoProductRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        barcode: barcode,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<FoodRepoProduct?> createElement() {
    return _FoodRepoProductProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is FoodRepoProductProvider && other.barcode == barcode;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, barcode.hashCode);

    return _SystemHash.finish(hash);
  }
}

mixin FoodRepoProductRef on AutoDisposeFutureProviderRef<FoodRepoProduct?> {
  /// The parameter `barcode` of this provider.
  String? get barcode;
}

class _FoodRepoProductProviderElement
    extends AutoDisposeFutureProviderElement<FoodRepoProduct?>
    with FoodRepoProductRef {
  _FoodRepoProductProviderElement(super.provider);

  @override
  String? get barcode => (origin as FoodRepoProductProvider).barcode;
}
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
