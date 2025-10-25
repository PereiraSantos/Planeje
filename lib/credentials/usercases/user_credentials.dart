import 'package:planeje/credentials/datasources/repository/database_repository.dart';
import 'package:planeje/credentials/entities/session.dart';
import 'package:planeje/credentials/entities/user.dart';
import 'package:planeje/credentials/repositories/user_repository.dart';
import 'package:planeje/credentials/usercases/session_manager.dart';

class UserCredentials implements UserRepository {
  final DatabaseRepository databaseRepository;

  UserCredentials(this.databaseRepository);

  @override
  Future<User> register(String email, String password) async {
    return await databaseRepository.saveUser(User(email, password));
  }

  @override
  Future<String> update(String token) async {
    return databaseRepository.update(token);
  }

  @override
  Future<String> forgot(String email) async {
    return '12345';
  }

  @override
  void logout(String email) {
    SessionManager().logout(email);
  }

  @override
  Session createSession(User user) {
    return SessionManager().createSession(user);
  }

  @override
  Future<User> findByEmail(String email, String password) async {
    return await databaseRepository.findByEmail(email, password);
  }
}
