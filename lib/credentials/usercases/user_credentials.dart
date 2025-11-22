import 'package:planeje/credentials/datasources/repository/user_database_repository.dart';
import 'package:planeje/credentials/entities/user.dart';
import 'package:planeje/credentials/repositories/user_repository.dart';

class UserCredentials implements UserRepository {
  final UserDatabaseRepository userDatabaseRepository;

  UserCredentials(this.userDatabaseRepository);

  @override
  Future<void> register(String email, String password) async {
    return await userDatabaseRepository.register(User(email, password));
  }

  @override
  Future<String> update(String token) async {
    return '12345';
    //  return userDatabaseRepository.update(token);
  }

  @override
  Future<User?> findByEmail(String email) async {
    return await userDatabaseRepository.findByEmail(email);
  }

  @override
  Future<int?> tableUserContainsRegister() async {
    return await userDatabaseRepository.tableUserContainsRegister();
  }
}
