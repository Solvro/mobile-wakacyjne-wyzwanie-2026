// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'places_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(Places)
const placesProvider = PlacesProvider._();

final class PlacesProvider extends $NotifierProvider<Places, List<Place>> {
  const PlacesProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'placesProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$placesHash();

  @$internal
  @override
  Places create() => Places();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<Place> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<Place>>(value),
    );
  }
}

String _$placesHash() => r'a694793a441d5b97cb05891aa0d8bd86d7a3a630';

abstract class _$Places extends $Notifier<List<Place>> {
  List<Place> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<List<Place>, List<Place>>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<List<Place>, List<Place>>, List<Place>, Object?, Object?>;
    element.handleValue(ref, created);
  }
}
