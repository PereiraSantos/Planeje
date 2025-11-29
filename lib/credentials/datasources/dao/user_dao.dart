import 'package:floor/floor.dart';
import 'package:planeje/credentials/entities/user.dart';

@dao
abstract class UserDao {
  @Insert()
  Future<void> register(User user);

  @Query('select * from user where email = :email and password = :password')
  Future<User?> findByEmailAndPassword(String email, String password);

  @Query('select * from user where email = :email')
  Future<User?> findByEmail(String email);

  @Query('select count(email) from user')
  Future<int?> tableUserContainsRegister();
}
