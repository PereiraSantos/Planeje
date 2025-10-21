abstract class AuthenticationRepository {
  Future<bool> authenticate(String email, String password);
  bool exchange(String token);
}
