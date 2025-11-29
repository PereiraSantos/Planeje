import 'package:planeje/credentials/entities/last_session.dart';

abstract class LastSessionDatabaseRepository {
  Future<LastSession?> findLastSession();
  Future<void> registerLastSession(LastSession lastSession);
  Future<void> update(LastSession lastSession);
}
