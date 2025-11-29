import 'package:planeje/credentials/datasources/repository/user_database_repository.dart';
import 'package:planeje/credentials/entities/user.dart';
import 'package:planeje/credentials/repositories/authentication_repository.dart';

class AuthenticationLocal implements AuthenticationRepository {
  final UserDatabaseRepository databaseRepository;

  AuthenticationLocal(this.databaseRepository);

  @override
  Future<bool> authenticate(String email, String password) async {
    User? user = await databaseRepository.findByEmailAndPassword(email, password);

    return (user?.email == email && user?.password == password);
  }

  @override
  bool exchange(String token) {
    return true;
  }
}
