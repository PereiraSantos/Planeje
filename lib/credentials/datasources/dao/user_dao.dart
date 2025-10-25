import 'package:floor/floor.dart';
import 'package:planeje/login/entities/user.dart';

@dao
abstract class UserDao {
  @insert
  Future<void> insertUser(User user);

  @Query('select * from user where login = :login and password = :password')
  Future<User?> findUserLoginPassword(String login, String password);

  @Query('select * from user where id = 1')
  Future<User?> findUserById();

  @Query('update user set keep_logged = :keepLogged')
  Future<int?> updateKeepLogged(bool keepLogged);
}
