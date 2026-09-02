// GENERATED CODE - DO NOT MODIFY BY HAND
// @dart=3.0

part of 'favorite_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(Favorite)
const favoriteProvider = FavoriteProvider._();

final class FavoriteProvider extends $NotifierProvider<Favorite, bool> {
  const FavoriteProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'favoriteProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$favoriteHash();

  @$internal
  @override
  Favorite create() => Favorite();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$favoriteHash() => r'e2214b520333b5a50ad7b8fe1bfd0e13c323d567';

abstract class _$Favorite extends $Notifier<bool> {
  bool build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<bool, bool>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<bool, bool>, bool, Object?, Object?>;
    element.handleValue(ref, created);
  }
}
