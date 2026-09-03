// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'places_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$placesRepositoryHash() => r'bf26d088bd97a0f5044f8793926ef0c078a400a1';

/// See also [placesRepository].
@ProviderFor(placesRepository)
final placesRepositoryProvider =
    AutoDisposeProvider<LocalPlacesRepository>.internal(
  placesRepository,
  name: r'placesRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$placesRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef PlacesRepositoryRef = AutoDisposeProviderRef<LocalPlacesRepository>;
String _$placesHash() => r'eb2f7cee0a9c1b9c061a4881981d108240e24a81';

/// See also [Places].
@ProviderFor(Places)
final placesProvider =
    AutoDisposeAsyncNotifierProvider<Places, List<DreamPlace>>.internal(
  Places.new,
  name: r'placesProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$placesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$Places = AutoDisposeAsyncNotifier<List<DreamPlace>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member
