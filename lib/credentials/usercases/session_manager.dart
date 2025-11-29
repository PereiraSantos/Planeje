import 'package:planeje/credentials/datasources/repository/last_session_database_repository.dart';
import 'package:planeje/credentials/datasources/repository/session_database_repository.dart';
import 'package:planeje/credentials/datasources/repository/user_database_repository.dart';
import 'package:planeje/credentials/entities/last_session.dart';
import 'package:planeje/credentials/entities/session.dart';
import 'package:planeje/credentials/entities/user.dart';
import 'package:planeje/credentials/repositories/session_repository.dart';

class SessionManager implements SessionRepository {
  static final SessionManager _sessionManager = SessionManager._internal();

  factory SessionManager() => _sessionManager;

  SessionManager._internal();

  Session? session;
  UserDatabaseRepository? userDatabaseRepository;
  SessionDatabaseRepository? sessionDatabaseRepository;
  LastSessionDatabaseRepository? lastSessionDatabaseRepository;

  void setUserDatabase(UserDatabaseRepository value) => userDatabaseRepository = value;
  void setSessionDatabase(SessionDatabaseRepository value) => sessionDatabaseRepository = value;
  void setLastSessionDatabase(LastSessionDatabaseRepository value) => lastSessionDatabaseRepository = value;

  Session createSession(User user) {
    session = Session(user.email, '', user: user, expiresAt: DateTime.now());

    register(session!);

    registerLastSession(LastSession(session!.emailUser));

    return session!;
  }

  Session? getSession() {
    return session;
  }

  bool invalidate(String email) {
    return getSession() == null;
  }

  @override
  Future<void> logout() async {
    await update(LastSession(session!.emailUser));

    session = null;

    await delete();
  }

  @override
  Future<int?> register(Session session) async {
    return await sessionDatabaseRepository!.registerSession(session);
  }

  @override
  Future<bool?> initSession() async {
    bool isRegisterUser = (await userDatabaseRepository!.tableUserContainsRegister()) != 0;
    if (!isRegisterUser) return null;

    Session? session = await sessionDatabaseRepository!.findSession();
    if (session == null) return false;

    await delete();

    User? user = await userDatabaseRepository!.findByEmail(session.emailUser);
    createSession(user!);

    return true;
  }

  @override
  Future<LastSession?> findLastSession() async {
    return await lastSessionDatabaseRepository!.findLastSession();
  }

  @override
  Future<void> registerLastSession(LastSession lastSession) async {
    LastSession? lastSession = await lastSessionDatabaseRepository!.findLastSession();
    lastSession != null ? update(lastSession) : lastSessionDatabaseRepository!.registerLastSession(LastSession(session!.emailUser));
  }

  @override
  Future<void> update(LastSession lastSession) async {
    lastSessionDatabaseRepository!.update(LastSession(session!.emailUser));
  }

  Future<User?> findUser() async {
    LastSession? lastSession = await findLastSession();

    if (lastSession != null) return userDatabaseRepository!.findByEmail(lastSession.email);
    return null;
  }

  @override
  Future<void> delete() async {
    await sessionDatabaseRepository!.delete();
  }
}
