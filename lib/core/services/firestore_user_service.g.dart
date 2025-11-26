// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'firestore_user_service.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(firestoreUserService)
const firestoreUserServiceProvider = FirestoreUserServiceProvider._();

final class FirestoreUserServiceProvider
    extends
        $FunctionalProvider<
          FirestoreUserService,
          FirestoreUserService,
          FirestoreUserService
        >
    with $Provider<FirestoreUserService> {
  const FirestoreUserServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'firestoreUserServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$firestoreUserServiceHash();

  @$internal
  @override
  $ProviderElement<FirestoreUserService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  FirestoreUserService create(Ref ref) {
    return firestoreUserService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(FirestoreUserService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<FirestoreUserService>(value),
    );
  }
}

String _$firestoreUserServiceHash() =>
    r'f4e4c230f19e007a22f56efd6eb994b7d9ea7615';
