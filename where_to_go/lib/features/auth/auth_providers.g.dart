// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AuthStatusController)
final authStatusControllerProvider = AuthStatusControllerProvider._();

final class AuthStatusControllerProvider
    extends $NotifierProvider<AuthStatusController, AuthenticationStatus> {
  AuthStatusControllerProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authStatusControllerProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authStatusControllerHash();

  @$internal
  @override
  AuthStatusController create() => AuthStatusController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AuthenticationStatus value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AuthenticationStatus>(value),
    );
  }
}

String _$authStatusControllerHash() =>
    r'a7dc1ca32ab2b0732ba63ef0e7b34e8aaa07afc7';

abstract class _$AuthStatusController extends $Notifier<AuthenticationStatus> {
  AuthenticationStatus build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AuthenticationStatus, AuthenticationStatus>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AuthenticationStatus, AuthenticationStatus>,
              AuthenticationStatus,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
