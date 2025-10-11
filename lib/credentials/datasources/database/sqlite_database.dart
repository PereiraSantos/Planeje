import 'package:planeje/credentials/datasources/repository/database_repository.dart';
import 'package:planeje/credentials/entities/user.dart';
import 'package:planeje/database/app_database.dart';

class SqliteDatabase implements DatabaseRepository {
  @override
  Future<bool> authentic(User user) async {
    final database = await getInstance();
    return true;
  }

  @override
  Future<bool> exchange(User user, String password) async {
    final database = await getInstance();
    return true;
  }

  @override
  Future<String> forgot(String login) async {
    final database = await getInstance();
    // gera um novo valor randomico e salva no banco
    // retorna para ser enviando via email
    return '000';
  }

  @override
  Future<bool> logout(User user) async {
    final database = await getInstance();
    return true;
  }

  @override
  Future<bool> register(User user) async {
    final database = await getInstance();
    return true;
  }
}
