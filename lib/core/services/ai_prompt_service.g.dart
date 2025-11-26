// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ai_prompt_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(aiPromptService)
const aiPromptServiceProvider = AiPromptServiceProvider._();

final class AiPromptServiceProvider
    extends
        $FunctionalProvider<AIPromptService, AIPromptService, AIPromptService>
    with $Provider<AIPromptService> {
  const AiPromptServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'aiPromptServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$aiPromptServiceHash();

  @$internal
  @override
  $ProviderElement<AIPromptService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AIPromptService create(Ref ref) {
    return aiPromptService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AIPromptService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AIPromptService>(value),
    );
  }
}

String _$aiPromptServiceHash() => r'bf42d9711415f843e982eab38668b355033580dc';
