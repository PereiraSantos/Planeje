import 'package:planeje/credentials/entities/last_session.dart';
import 'package:planeje/credentials/entities/session.dart';

abstract class SessionRepository {
  Future<int?> register(Session session);
  Future<void> delete();
  Future<void> logout();
  Future<bool?> initSession();
  Future<LastSession?> findLastSession();
  Future<void> registerLastSession(LastSession lastSession);
  Future<void> update(LastSession lastSession);
}
