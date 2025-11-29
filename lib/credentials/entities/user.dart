import 'package:floor/floor.dart';

@Entity(tableName: 'user')
class User {
  @PrimaryKey(autoGenerate: false)
  @ColumnInfo(name: 'email')
  String email;

  @ColumnInfo(name: 'password')
  String password;

  User(this.email, this.password);
}
