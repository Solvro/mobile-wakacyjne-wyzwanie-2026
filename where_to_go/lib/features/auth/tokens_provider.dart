import "package:flutter/foundation.dart";
import "package:riverpod/riverpod.dart";
import "authentication_repository_provider.dart";

final tokensProvider = FutureProvider<(String?, String?)>((ref) async {
  debugPrint("[TokensProvider] Getting tokens...");
  final authRepo = ref.read(authenticationRepositoryProvider);
  final persisted = await authRepo.readTokens(); // (String? access, String? refresh)
  final access = persisted.$1;
  final refresh = persisted.$2;

  if (access != null && refresh != null) {
    debugPrint(
        "[TokensProvider] Retrieved tokens - access: ${access.substring(0, 10)}..., refresh: ${refresh.substring(0, 10)}...");
  } else {
    debugPrint("[TokensProvider] No tokens found in storage: ($access, $refresh)");
    return (null, null);
  }

  try {
    debugPrint("[TokensProvider] Attempting to refresh token...");
    // final freshAccess = await authRepo.refreshToken(refresh) as String;
    final freshAccess = access;

    debugPrint("[TokensProvider] Token refreshed successfully. New access token: ${freshAccess.substring(0, 10)}...");
    // persist fresh tokens and return them
    await authRepo.saveTokens(freshAccess, refresh);
    debugPrint("[TokensProvider] Tokens saved, returning new pair");
    return (freshAccess, refresh);
  } on Object catch (e) {
    debugPrint("[TokensProvider] Exception during token refresh: $e");
    // refresh failed — delete persisted tokens and return null
    await authRepo.deleteTokens();
    return (null, null);
  }

  // Refresh tokenów działał jeszcze niedawno, teraz jednak otrzymuję ciągle błąd 401, message: Invalid or expired refresh token, pomimo uzyskania refresh tokenu chwilę przed wezwaniem refreshToken
});
