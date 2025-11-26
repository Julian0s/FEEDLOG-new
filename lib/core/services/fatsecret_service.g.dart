// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'fatsecret_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(fatSecretService)
const fatSecretServiceProvider = FatSecretServiceProvider._();

final class FatSecretServiceProvider
    extends
        $FunctionalProvider<
          FatSecretService,
          FatSecretService,
          FatSecretService
        >
    with $Provider<FatSecretService> {
  const FatSecretServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'fatSecretServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$fatSecretServiceHash();

  @$internal
  @override
  $ProviderElement<FatSecretService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  FatSecretService create(Ref ref) {
    return fatSecretService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FatSecretService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FatSecretService>(value),
    );
  }
}

String _$fatSecretServiceHash() => r'021252266df2de8ccdc68ed7dbea1559648ccc3c';
