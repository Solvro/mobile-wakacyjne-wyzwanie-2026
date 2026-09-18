// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theme_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(Themem)
final thememProvider = ThememProvider._();

final class ThememProvider extends $AsyncNotifierProvider<Themem, bool?> {
  ThememProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'thememProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$thememHash();

  @$internal
  @override
  Themem create() => Themem();
}

String _$thememHash() => r'943a85ff99330b254d12c8e645a21bc176600432';

abstract class _$Themem extends $AsyncNotifier<bool?> {
  FutureOr<bool?> build();
  @$mustCallSuper
  @override
  WhenComplete runBuild() {
    final ref = this.ref as $Ref<AsyncValue<bool?>, bool?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<bool?>, bool?>,
              AsyncValue<bool?>,
              Object?,
              Object?
            >;
    return element.handleCreate(ref, build);
  }
}
