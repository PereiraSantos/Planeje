import 'package:planeje/credentials/datasources/repository/database_repository.dart';
import 'package:planeje/credentials/entities/user.dart';
import 'package:planeje/credentials/repositories/credentials_repository.dart';

class Credentials implements CredentialsRepository {
  final DatabaseRepository databaseRepository;

  Credentials(this.databaseRepository);

  @override
  Future<bool> authentic(User user) async {
    return databaseRepository.authentic(user);
  }

  @override
  Future<bool> exchange(User user, String password) async {
    return databaseRepository.exchange(user, password);
  }

  @override
  Future<String> forgot(String login) async {
    return await databaseRepository.forgot(login);
  }

  @override
  Future<bool> logout(User user) async {
    return databaseRepository.logout(user);
  }

  @override
  Future<bool> register(User user) async {
    return databaseRepository.register(user);
  }
}
