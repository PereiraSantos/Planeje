import 'package:planeje/credentials/datasources/repository/session_database_repository.dart';

import 'package:planeje/credentials/entities/session.dart';
import 'package:planeje/database/app_database.dart';

class SqliteSession implements SessionDatabaseRepository {
  @override
  Future<int?> registerSession(Session session) async {
    final database = await getInstance();

    return await database.sessionDao.register(session);
  }

  @override
  Future<void> delete() async {
    final database = await getInstance();

    return await database.sessionDao.delete();
  }

  @override
  Future<Session?> findSession() async {
    final database = await getInstance();

    return await database.sessionDao.findSession();
  }
}
