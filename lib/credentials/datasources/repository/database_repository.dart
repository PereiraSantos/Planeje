import 'package:planeje/credentials/entities/user.dart';

abstract class DatabaseRepository {
  Future<bool> register(User user);
  Future<bool> authentic(User user);
  Future<String> forgot(String login);
  Future<bool> logout(User user);
  Future<bool> exchange(User user, String password);
}
