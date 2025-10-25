import 'package:floor/floor.dart';

@Entity(tableName: 'user')
class User {
  @PrimaryKey(autoGenerate: false)
  @ColumnInfo(name: 'id')
  int? id;

  @ColumnInfo(name: 'email')
  String email;

  @ColumnInfo(name: 'password')
  String password;

  User(this.email, this.password, {this.id});
}
