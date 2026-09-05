// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'places_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(Places)
final placesProvider = PlacesProvider._();

final class PlacesProvider extends $NotifierProvider<Places, List<Place>> {
  PlacesProvider._()
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
    return $ProviderOverride(origin: this, providerOverride: $SyncValueProvider<List<Place>>(value));
  }
}

String _$placesHash() => r'a5a9faebb8cd7146774fdcf90d8ac9476cd8a853';

abstract class _$Places extends $Notifier<List<Place>> {
  List<Place> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<List<Place>, List<Place>>;
    final element =
        ref.element as $ClassProviderElement<AnyNotifier<List<Place>, List<Place>>, List<Place>, Object?, Object?>;
    element.handleCreate(ref, build);
  }
}
