import 'package:planeje/credentials/datasources/repository/database_repository.dart';
import 'package:planeje/credentials/entities/user.dart';
import 'package:planeje/credentials/repositories/authentication_repository.dart';
import 'package:planeje/credentials/usercases/session_manager.dart';

class AuthenticationLocal implements AuthenticationRepository {
  final DatabaseRepository databaseRepository;

  AuthenticationLocal(this.databaseRepository);

  @override
  Future<bool> authenticate(String email, String password) async {
    User user = await databaseRepository.findByEmail(email, password);

    if (user.email == email && user.password == password) {
      SessionManager().createSession(user);
      return true;
    }

    return false;
  }

  @override
  bool exchange(String token) {
    // TODO: implement exchange
    throw UnimplementedError();
  }
}
