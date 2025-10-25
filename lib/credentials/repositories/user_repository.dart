import 'package:planeje/credentials/entities/session.dart';
import 'package:planeje/credentials/entities/user.dart';

abstract class UserRepository {
  Future<User> register(String email, String password);
  Future<User> findByEmail(String email, String password);
  Future<String> update(String token);
  Future<String> forgot(String email);
  void logout(String sessionId);
  Session createSession(User user);
}
