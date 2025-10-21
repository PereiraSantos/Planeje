import 'package:planeje/credentials/repositories/authentication_repository.dart';

class AuthenticationHttp implements AuthenticationRepository {
  @override
  Future<bool> authenticate(String email, String password) async {
    // TODO: implement authenticate
    throw UnimplementedError();
  }

  @override
  bool exchange(String token) {
    // TODO: implement exchange
    throw UnimplementedError();
  }
}
