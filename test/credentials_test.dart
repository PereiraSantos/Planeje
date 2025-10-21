import 'package:flutter_test/flutter_test.dart';

import 'package:planeje/credentials/datasources/repository/database_repository.dart';
import 'package:planeje/credentials/entities/session.dart';
import 'package:planeje/credentials/entities/user.dart';
import 'package:planeje/credentials/repositories/authentication_repository.dart';
import 'package:planeje/credentials/repositories/user_repository.dart';
import 'package:planeje/credentials/usercases/authentication_local.dart';
import 'package:planeje/credentials/usercases/session_manager.dart';
import 'package:planeje/credentials/usercases/user_credentials.dart';

class SqliteDatabaseMock implements DatabaseRepository {
  List<User> users = [];

  @override
  Future<User> findByEmail(String email, String password) async {
    return User('email@teste.com', '123');
  }

  @override
  Future<User> saveUser(User user) async {
    return user;
  }

  @override
  Future<String> update(String token) async {
    return '12345';
  }
}

void main() {
  AuthenticationRepository authenticationLocal = AuthenticationLocal(SqliteDatabaseMock());
  UserRepository authentication = UserCredentials(SqliteDatabaseMock());

  group('Credenciais', () {
    test('Registrar novo usuário ', () async {
      User user = await authentication.register("email@teste.com", "123");

      expect(user.email, 'email@teste.com');
      expect(user.password, '123');
    });

    test('autenticação bem-sucedida local', () async {
      bool auth = await authenticationLocal.authenticate("email@teste.com", "123");
      Session? session = SessionManager().getSession("email@teste.com");

      expect(auth, true);
      expect(session!.id, 'email@teste.com');
    });

    test('autenticação falha', () async {
      bool auth = await authenticationLocal.authenticate("email@teste.com", "122");

      expect(auth, false);
    });

    test('autenticação troca de senha com usuário válido', () async {
      User user = await authentication.findByEmail("email@teste.com", "123");
      String passwordTemp = await authentication.update(user.email);

      expect(passwordTemp, '12345');
    });

    test('autenticação troca de senha com usuário invalido', () async {
      User user = await authentication.findByEmail("email@teste.com", "122");
      String passwordTemp = await authentication.update(user.email);

      expect(passwordTemp, '12345');
    });
  });
}
