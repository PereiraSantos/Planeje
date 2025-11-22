import 'package:planeje/credentials/datasources/database/sqlite_last_session.dart';
import 'package:planeje/credentials/datasources/database/sqlite_session.dart';
import 'package:planeje/credentials/datasources/database/sqlite_user.dart';
import 'package:planeje/credentials/entities/user.dart';
import 'package:planeje/credentials/usercases/authentication_local.dart';
import 'package:planeje/credentials/usercases/session_manager.dart';

class LoginUsercases {
  final SessionManager sessionManager = SessionManager();
  String? _email;
  String? _password;

  void setEmail(String value) => _email = value;
  void setPassword(String value) => _password = value;

  Future<bool> register() async {
    bool isAuth = await AuthenticationLocal(SqliteUser()).authenticate(_email!, _password!);
    if (!isAuth) return isAuth;

    _initSesseion();

    return isAuth;
  }

  void _initSesseion() {
    final SessionManager sessionManager = SessionManager();

    sessionManager.setUserDatabase(SqliteUser());
    sessionManager.setSessionDatabase(SqliteSession());
    sessionManager.setLastSessionDatabase(SqliteLastSession());
    sessionManager.delete();
    sessionManager.createSession(User(_email!, _password!));
  }

  void setUserDatabase() => sessionManager.setUserDatabase(SqliteUser());

  Future<User?> findUser() async => await sessionManager.findUser();
}
