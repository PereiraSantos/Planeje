import 'package:floor/floor.dart';

@Entity(tableName: 'goal')
class Goal {
  @PrimaryKey(autoGenerate: true)
  @ColumnInfo(name: 'id')
  int? id;

  @ColumnInfo()
  String? description;

  @ColumnInfo()
  String? complement;

  @ColumnInfo()
  String? date;

  @ColumnInfo()
  bool? concluded;

  Goal({this.id, this.description, this.complement, this.date, this.concluded = false});
}
