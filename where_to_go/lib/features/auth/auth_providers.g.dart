// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(AuthStatus)
final authStatusProvider = AuthStatusProvider._();

final class AuthStatusProvider
    extends $NotifierProvider<AuthStatus, AuthenticationStatus> {
  AuthStatusProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'authStatusProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$authStatusHash();

  @$internal
  @override
  AuthStatus create() => AuthStatus();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AuthenticationStatus value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AuthenticationStatus>(value),
    );
  }
}

String _$authStatusHash() => r'2aeba955caf6342248c959e2b94d0018419d3e84';

abstract class _$AuthStatus extends $Notifier<AuthenticationStatus> {
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
