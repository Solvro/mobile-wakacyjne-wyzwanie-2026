// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'places_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$sortOrderHash() => r'4a87150e1390f874efebfe7122ac52f305cb7d2f';

/// See also [sortOrder].
@ProviderFor(sortOrder)
final sortOrderProvider = AutoDisposeProvider<SortOrder>.internal(
  sortOrder,
  name: r'sortOrderProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product') ? null : _$sortOrderHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef SortOrderRef = AutoDisposeProviderRef<SortOrder>;
String _$placesHash() => r'1faea715800853b9408e3c9907e91984a19b00bf';

/// See also [Places].
@ProviderFor(Places)
final placesProvider = AutoDisposeNotifierProvider<Places, List<Place>>.internal(
  Places.new,
  name: r'placesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product') ? null : _$placesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

typedef _$Places = AutoDisposeNotifier<List<Place>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
