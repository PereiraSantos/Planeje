import 'package:flutter_test/flutter_test.dart';

import 'package:planeje/credentials/datasources/repository/database_repository.dart';
import 'package:planeje/credentials/entities/user.dart';
import 'package:planeje/credentials/usercases/credentials.dart';

class SqliteDatabaseMock implements DatabaseRepository {
  List<User> users = [];

  @override
  Future<bool> register(User user) async {
    users.add(user);
    return true;
  }

  @override
  Future<bool> authentic(User user) async {
    List<User> result = users.where((e) => e.login == user.login && e.password == user.password).toList();
    if (result.isNotEmpty) return true;
    return false;
  }

  @override
  Future<bool> exchange(User user, String password) async {
    int index = users.indexWhere((e) => e.password == user.password);

    users[index].password = password;

    return true;
  }

  @override
  Future<String> forgot(String login) async {
    int index = users.indexWhere((e) => e.login == login);

    users[index].password = '000';

    return users[index].password;
  }

  @override
  Future<bool> logout(User user) async {
    users.removeWhere((e) => e.id == user.id);
    return true;
  }
}

void main() {
  group('Credenciais', () {
    Credentials credentials = Credentials(SqliteDatabaseMock());
    User user = User('m', '123', true);

    test('Espero que registre um usuário', () async {
      bool result = await credentials.register(user);

      expect(result, true);
    });

    test('Autenticação do usuário - espero que retorne verdadeiro', () async {
      bool result = await credentials.authentic(user);

      expect(result, true);
    });

    test('Autenticação do usuário incorreto - espero que retorne false', () async {
      bool result = await credentials.authentic(User('j', '123', false));

      expect(result, false);
    });

    test('Espero que troque de senha', () async {
      bool result = await credentials.exchange(user, '321');

      expect(result, true);
    });

    test('Espero uma nova senha', () async {
      String result = await credentials.forgot('m');

      expect(result, '000');
    });

    test('Espero deslogar', () async {
      bool result = await credentials.logout(user);

      expect(result, true);
    });
  });
}
