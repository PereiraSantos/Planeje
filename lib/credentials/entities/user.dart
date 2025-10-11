import 'package:floor/floor.dart';

@Entity(tableName: 'user')
class User {
  @PrimaryKey(autoGenerate: false)
  @ColumnInfo(name: 'id')
  int id = 1;

  @ColumnInfo(name: 'login')
  String login;

  @ColumnInfo(name: 'password')
  String password;

  @ColumnInfo(name: 'keep_logged')
  bool keepLogged;

  User(this.login, this.password, this.keepLogged);
}
