// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dream_places_repository.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(dreamPlacesRepository)
final dreamPlacesRepositoryProvider = DreamPlacesRepositoryProvider._();

final class DreamPlacesRepositoryProvider
    extends $FunctionalProvider<DreamPlacesRepository, DreamPlacesRepository, DreamPlacesRepository>
    with $Provider<DreamPlacesRepository> {
  DreamPlacesRepositoryProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'dreamPlacesRepositoryProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$dreamPlacesRepositoryHash();

  @$internal
  @override
  $ProviderElement<DreamPlacesRepository> $createElement($ProviderPointer pointer) => $ProviderElement(pointer);

  @override
  DreamPlacesRepository create(Ref ref) {
    return dreamPlacesRepository(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(DreamPlacesRepository value) {
    return $ProviderOverride(origin: this, providerOverride: $SyncValueProvider<DreamPlacesRepository>(value));
  }
}

String _$dreamPlacesRepositoryHash() => r'385e2e242c0fb37a30c75dd12e847ba128fc1d60';
