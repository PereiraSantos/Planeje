import 'package:planeje/credentials/entities/session.dart';

abstract class SessionDatabaseRepository {
  Future<int?> registerSession(Session session);
  Future<void> delete();
  Future<Session?> findSession();
}
