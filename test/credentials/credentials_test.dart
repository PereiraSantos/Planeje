import 'package:flutter_test/flutter_test.dart';

import 'package:planeje/credentials/datasources/repository/user_database_repository.dart';
import 'package:planeje/credentials/entities/last_session.dart';
import 'package:planeje/credentials/entities/session.dart';
import 'package:planeje/credentials/entities/user.dart';
import 'package:planeje/credentials/repositories/authentication_repository.dart';
import 'package:planeje/credentials/repositories/user_repository.dart';
import 'package:planeje/credentials/usercases/authentication_local.dart';
import 'package:planeje/credentials/usercases/session_manager.dart';
import 'package:planeje/credentials/usercases/user_credentials.dart';

import 'last_session_mock.dart';
import 'session_mock.dart';

class SqliteUserMock implements UserDatabaseRepository {
  List<User> users = [];

  @override
  Future<User> findByEmail(String email) async {
    return User('email@teste.com', '123');
  }

  @override
  Future<User> register(User user) async {
    return user;
  }

  @override
  Future<User?> findByEmailAndPassword(String email, String password) async {
    return User('email@teste.com', '123');
  }

  @override
  Future<int?> tableUserContainsRegister() async {
    return 1;
  }
}

void main() {
  AuthenticationRepository authenticationLocal = AuthenticationLocal(SqliteUserMock());
  UserRepository authentication = UserCredentials(SqliteUserMock());

  SessionManager sessionManager = SessionManager();
  sessionManager.setUserDatabase(SqliteUserMock());
  sessionManager.setSessionDatabase(SqliteSessionMock());
  sessionManager.setLastSessionDatabase(SqliteLastSessionMock());

  group('Credenciais', () {
    test('Registrar novo usuário ', () async {
      await authentication.register("email@teste.com", "123");

      var user = User("email@teste.com", "123");

      expect(user.email, 'email@teste.com');
      expect(user.password, '123');
    });

    test('autenticação bem-sucedida local', () async {
      bool auth = await authenticationLocal.authenticate("email@teste.com", "123");
      sessionManager.createSession(User("email@teste.com", "123"));
      Session? session = sessionManager.getSession();

      expect(auth, true);
      expect(session!.emailUser, 'email@teste.com');
    });

    test('autenticação falha', () async {
      bool auth = await authenticationLocal.authenticate("email@teste.com", "122");

      expect(auth, false);
    });

    test('autenticação troca de senha com usuário válido', () async {
      User? user = await authentication.findByEmail("email@teste.com");
      String passwordTemp = await authentication.update(user!.email);

      expect(passwordTemp, '12345');
    });

    test('autenticação troca de senha com usuário invalido', () async {
      User? user = await authentication.findByEmail("email1@teste.com");
      String passwordTemp = await authentication.update(user!.email);

      expect(passwordTemp, '12345');
    });
  });

  group('Sessão', () {
    test('Registre uma sessão', () async {
      int? id = await sessionManager.register(Session('email@teste.com', ''));

      expect(id, 1);
    });

    test('espero que tenha a ultima sessão', () async {
      LastSession? lastSession = await sessionManager.findLastSession();

      expect(lastSession?.email, 'email@teste.com');
    });

    test('Espero que tenha um registro no banco', () async {
      int? id = await authentication.tableUserContainsRegister();

      expect(id, 1);
    });
  });
}
