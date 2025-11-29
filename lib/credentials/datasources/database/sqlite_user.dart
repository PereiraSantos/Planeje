import 'package:planeje/credentials/datasources/repository/user_database_repository.dart';

import 'package:planeje/credentials/entities/user.dart';
import 'package:planeje/database/app_database.dart';

class SqliteUser implements UserDatabaseRepository {
  @override
  Future<User?> findByEmailAndPassword(String email, String password) async {
    final database = await getInstance();
    return await database.userDao.findByEmailAndPassword(email, password);
  }

  @override
  Future<void> register(User user) async {
    final database = await getInstance();

    return await database.userDao.register(user);
  }

  @override
  Future<User?> findByEmail(String email) async {
    final database = await getInstance();

    return await database.userDao.findByEmail(email);
  }

  @override
  Future<int?> tableUserContainsRegister() async {
    final database = await getInstance();

    return await database.userDao.tableUserContainsRegister();
  }
}
