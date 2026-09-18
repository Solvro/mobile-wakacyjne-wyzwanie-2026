// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'places_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(Places)
final placesProvider = PlacesProvider._();

final class PlacesProvider extends $AsyncNotifierProvider<Places, List<Place>> {
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
}

String _$placesHash() => r'8b03ba3b4dd19e7d8a85555a96696efaad3e90a8';

abstract class _$Places extends $AsyncNotifier<List<Place>> {
  FutureOr<List<Place>> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<Place>>, List<Place>>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AsyncValue<List<Place>>, List<Place>>,
        AsyncValue<List<Place>>,
        Object?,
        Object?>;
    return element.handleCreate(ref, build);
  }
}
