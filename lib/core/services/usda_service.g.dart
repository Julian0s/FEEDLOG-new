// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'usda_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(usdaService)
const usdaServiceProvider = UsdaServiceProvider._();

final class UsdaServiceProvider
    extends $FunctionalProvider<UsdaService, UsdaService, UsdaService>
    with $Provider<UsdaService> {
  const UsdaServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'usdaServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$usdaServiceHash();

  @$internal
  @override
  $ProviderElement<UsdaService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  UsdaService create(Ref ref) {
    return usdaService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UsdaService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<UsdaService>(value),
    );
  }
}

String _$usdaServiceHash() => r'7a07fc342020af07302cc6ed0e5b055e3d452bdf';
