// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'nutrition_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(nutritionService)
const nutritionServiceProvider = NutritionServiceProvider._();

final class NutritionServiceProvider
    extends
        $FunctionalProvider<
          NutritionService,
          NutritionService,
          NutritionService
        >
    with $Provider<NutritionService> {
  const NutritionServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'nutritionServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$nutritionServiceHash();

  @$internal
  @override
  $ProviderElement<NutritionService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  NutritionService create(Ref ref) {
    return nutritionService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(NutritionService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<NutritionService>(value),
    );
  }
}

String _$nutritionServiceHash() => r'88464f2ef1670e6568f509b2877f295c7d85144d';
