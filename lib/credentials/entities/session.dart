import 'package:floor/floor.dart';
import 'package:planeje/credentials/entities/user.dart';

@Entity(tableName: 'session')
class Session {
  @PrimaryKey(autoGenerate: false)
  @ColumnInfo(name: 'id')
  int id = 1;

  @ColumnInfo(name: 'email_user')
  String emailUser;

  @ColumnInfo(name: 'token')
  String token;

  @ignore
  User? user;

  @ignore
  DateTime? expiresAt;

  @ignore
  bool? isValid;

  Session(this.emailUser, this.token, {this.isValid = true, this.user, this.expiresAt});
}
