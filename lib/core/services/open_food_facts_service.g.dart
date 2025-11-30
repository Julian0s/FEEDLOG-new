// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'open_food_facts_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(openFoodFactsService)
const openFoodFactsServiceProvider = OpenFoodFactsServiceProvider._();

final class OpenFoodFactsServiceProvider
    extends
        $FunctionalProvider<
          OpenFoodFactsService,
          OpenFoodFactsService,
          OpenFoodFactsService
        >
    with $Provider<OpenFoodFactsService> {
  const OpenFoodFactsServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'openFoodFactsServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$openFoodFactsServiceHash();

  @$internal
  @override
  $ProviderElement<OpenFoodFactsService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  OpenFoodFactsService create(Ref ref) {
    return openFoodFactsService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(OpenFoodFactsService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<OpenFoodFactsService>(value),
    );
  }
}

String _$openFoodFactsServiceHash() =>
    r'319982a138146ea2d26d34dea31e6aca3b07dd58';
