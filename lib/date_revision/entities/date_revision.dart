import 'package:floor/floor.dart';
import 'package:planeje/utils/format_date.dart';

@Entity(tableName: 'date_revision')
class DateRevision {
  @PrimaryKey(autoGenerate: true)
  @ColumnInfo(name: 'id_date')
  int? id;

  @ColumnInfo(name: 'date_revision')
  String? dateRevision;

  @ColumnInfo(name: 'id_revision')
  int? idRevision;

  @ColumnInfo(name: 'sync')
  bool? sync;

  @ColumnInfo(name: 'disable')
  bool? disable;

  @ColumnInfo(name: 'insert_app')
  bool? insertApp;

  DateRevision({
    this.id,
    this.dateRevision,
    this.idRevision,
    this.sync = true,
    this.disable = false,
    this.insertApp = false,
  });

  void setId(int? value) => id = value;
  void setDate(String? value) => dateRevision = value ?? FormatDate.formatDate(DateTime.now());
  void setIdRevision(int? value) => idRevision = value;
  void setSync(bool? value) => sync = value ?? false;
  void setDisable(bool value) => disable = value;
  void setInsertApp(bool value) => insertApp = value;

  static DateRevision fromMapToObject(Map<String, dynamic> json) => DateRevision(
        id: json['id'],
        dateRevision: json['dateRevision'],
        idRevision: json['idRevision'],
      );

  static Map<String, dynamic> fromObjectToMap(DateRevision dateRevision) => {
        "id": dateRevision.id,
        "dateRevision": dateRevision.dateRevision,
        "idRevision": dateRevision.idRevision,
      };
}
