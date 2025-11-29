import 'package:floor/floor.dart';

@Entity(tableName: 'last_session')
class LastSession {
  @PrimaryKey(autoGenerate: false)
  @ColumnInfo(name: 'id')
  int id = 1;

  @ColumnInfo(name: 'email')
  String email;

  LastSession(this.email);
}
