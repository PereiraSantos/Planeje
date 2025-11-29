import 'package:planeje/credentials/datasources/repository/session_database_repository.dart';
import 'package:planeje/credentials/entities/session.dart';

class SqliteSessionMock implements SessionDatabaseRepository {
  @override
  Future<int?> registerSession(Session session) async {
    return 1;
  }

  @override
  Future<void> delete() async {}

  @override
  Future<Session?> findSession() async {
    return Session('email@teste.com', '');
  }
}
