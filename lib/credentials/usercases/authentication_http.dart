import 'package:planeje/credentials/repositories/authentication_repository.dart';

class AuthenticationHttp implements AuthenticationRepository {
  @override
  Future<bool> authenticate(String email, String password) async {
    return true;
  }

  @override
  bool exchange(String token) {
    return true;
  }
}
