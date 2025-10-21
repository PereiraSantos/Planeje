import 'package:planeje/credentials/entities/user.dart';

class Session {
  String id;
  User user;
  DateTime expiresAt;
  bool? isValid;

  Session(this.id, this.user, this.expiresAt, [this.isValid = true]);
}
