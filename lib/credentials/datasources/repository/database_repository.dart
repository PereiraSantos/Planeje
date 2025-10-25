import 'package:planeje/credentials/entities/user.dart';

abstract class DatabaseRepository {
  Future<User> saveUser(User user);
  Future<User> findByEmail(String email, String password);
  Future<String> update(String token);
}
