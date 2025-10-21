import 'package:planeje/credentials/entities/session.dart';
import 'package:planeje/credentials/entities/user.dart';

class SessionManager {
  static final SessionManager _sessionManager = SessionManager._internal();

  factory SessionManager() => _sessionManager;

  SessionManager._internal();

  Map<String, Session> sesseions = {};

  Session createSession(User user) {
    Session session = Session(user.email, user, DateTime.now());
    sesseions[user.email] = session;
    return session;
  }

  Session? getSession(String id) {
    return sesseions[id];
  }

  bool invalidate(String email) {
    return getSession(email) == null;
  }

  void logout(String email) {
    sesseions.remove(email);
  }
}
