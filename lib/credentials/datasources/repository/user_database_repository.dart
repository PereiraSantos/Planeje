import 'package:planeje/credentials/entities/user.dart';

abstract class UserDatabaseRepository {
  Future<void> register(User user);
  Future<User?> findByEmailAndPassword(String email, String password);
  Future<User?> findByEmail(String email);
  Future<int?> tableUserContainsRegister();
}
