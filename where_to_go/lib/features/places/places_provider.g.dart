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

String _$placesHash() => r'b743d0d20d96c3fd27a64ba302e5e41b26afc845';

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
