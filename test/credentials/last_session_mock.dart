import 'package:planeje/credentials/datasources/repository/last_session_database_repository.dart';
import 'package:planeje/credentials/entities/last_session.dart';

class SqliteLastSessionMock implements LastSessionDatabaseRepository {
  @override
  Future<LastSession?> findLastSession() async {
    return LastSession('email@teste.com');
  }

  @override
  Future<void> registerLastSession(LastSession lastSession) async {}

  @override
  Future<void> update(LastSession lastSession) async {}
}
