import "local_authentication_repository.dart";
import "remote_authentication_repository.dart";

class AuthenticationRepository {
  final LocalAuthenticationRepository localAuthRepo;
  final RemoteAuthenticationRepository remoteAuthRepo;

  AuthenticationRepository({
    required this.localAuthRepo,
    required this.remoteAuthRepo
  });

  Future<bool> isLogged() async{
    final accessToken = await localAuthRepo.readAccessToken();
    return accessToken != null;
  }

  Future<void> login(String email, String password) async{
    final tokens = await remoteAuthRepo.login(email, password);
    await localAuthRepo.writeAccessToken(tokens.accessToken);
  }

  Future<void> register(String email, String password) async{
    final tokens = await remoteAuthRepo.register(email, password);
    await localAuthRepo.writeAccessToken(tokens.accessToken);
  }

  Future<void> logout() async {
    await localAuthRepo.deleteAccessToken();
    await localAuthRepo.deleteRefreshToken();
  }
}
