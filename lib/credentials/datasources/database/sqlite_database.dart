import 'package:planeje/credentials/datasources/repository/database_repository.dart';
import 'package:planeje/credentials/entities/user.dart';
import 'package:planeje/database/app_database.dart';

class SqliteDatabase implements DatabaseRepository {
  @override
  Future<User> findByEmail(String email, String password) async {
    final database = await getInstance();
    return User('', '');
  }

  @override
  Future<User> saveUser(User user) async {
    final database = await getInstance();

    return user;
  }

  @override
  Future<String> update(String token) async {
    final database = await getInstance();
    return '12345';
  }
}
