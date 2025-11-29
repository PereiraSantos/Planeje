import 'package:planeje/credentials/datasources/repository/last_session_database_repository.dart';

import 'package:planeje/credentials/entities/last_session.dart';

import 'package:planeje/database/app_database.dart';

class SqliteLastSession implements LastSessionDatabaseRepository {
  @override
  Future<LastSession?> findLastSession() async {
    final database = await getInstance();

    return await database.lastSessionDao.findLastSession();
  }

  @override
  Future<void> registerLastSession(LastSession lastSession) async {
    final database = await getInstance();

    return await database.lastSessionDao.register(lastSession);
  }

  @override
  Future<void> update(LastSession lastSession) async {
    final database = await getInstance();

    return await database.lastSessionDao.update(lastSession);
  }
}
