// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'locale_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(LocaleNotifier)
const localeProvider = LocaleNotifierProvider._();

final class LocaleNotifierProvider
    extends $NotifierProvider<LocaleNotifier, Locale> {
  const LocaleNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'localeProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$localeNotifierHash();

  @$internal
  @override
  LocaleNotifier create() => LocaleNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Locale value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Locale>(value),
    );
  }
}

String _$localeNotifierHash() => r'd46933a74fdfe2753a3d457de03620f42794e46f';

abstract class _$LocaleNotifier extends $Notifier<Locale> {
  Locale build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<Locale, Locale>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<Locale, Locale>,
              Locale,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}

/// Provider for AppLocalizations based on current locale
/// This allows using translations without BuildContext

@ProviderFor(l10n)
const l10nProvider = L10nProvider._();

/// Provider for AppLocalizations based on current locale
/// This allows using translations without BuildContext

final class L10nProvider
    extends
        $FunctionalProvider<
          AppLocalizations,
          AppLocalizations,
          AppLocalizations
        >
    with $Provider<AppLocalizations> {
  /// Provider for AppLocalizations based on current locale
  /// This allows using translations without BuildContext
  const L10nProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'l10nProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$l10nHash();

  @$internal
  @override
  $ProviderElement<AppLocalizations> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AppLocalizations create(Ref ref) {
    return l10n(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AppLocalizations value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AppLocalizations>(value),
    );
  }
}

String _$l10nHash() => r'd7fd48e306ba4ca3a760673dc3cfd9e68db487ac';

@ProviderFor(UserProfilePhotoNotifier)
const userProfilePhotoProvider = UserProfilePhotoNotifierProvider._();

final class UserProfilePhotoNotifierProvider
    extends $NotifierProvider<UserProfilePhotoNotifier, UserProfilePhoto> {
  const UserProfilePhotoNotifierProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'userProfilePhotoProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$userProfilePhotoNotifierHash();

  @$internal
  @override
  UserProfilePhotoNotifier create() => UserProfilePhotoNotifier();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(UserProfilePhoto value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<UserProfilePhoto>(value),
    );
  }
}

String _$userProfilePhotoNotifierHash() =>
    r'c79d5f38da61b7f2f6e329dd12102a033db548c5';

abstract class _$UserProfilePhotoNotifier extends $Notifier<UserProfilePhoto> {
  UserProfilePhoto build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<UserProfilePhoto, UserProfilePhoto>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<UserProfilePhoto, UserProfilePhoto>,
              UserProfilePhoto,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
