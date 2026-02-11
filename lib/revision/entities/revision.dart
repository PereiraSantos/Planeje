import 'package:floor/floor.dart';
import 'package:planeje/utils/format_date.dart';

@Entity(tableName: 'revision')
class Revision {
  @PrimaryKey(autoGenerate: true)
  @ColumnInfo(name: 'id')
  int? id;

  @ColumnInfo(name: 'title')
  String? title;

  @ColumnInfo(name: 'description')
  String? description;

  @ColumnInfo(name: 'date_creational')
  String? dateCreational;

  @ColumnInfo(name: 'id_revision_theme')
  int? idRevisionTheme;

  @ColumnInfo(name: 'sync')
  bool? sync;

  @ColumnInfo(name: 'disable')
  bool? disable;

  @ColumnInfo(name: 'insert_app')
  bool? insertApp;

  Revision({this.id, this.title, this.description, this.dateCreational, this.idRevisionTheme, this.sync = true, this.disable = false, this.insertApp = false});

  void setId(int? value) => id = value;
  void setTitle(String value) => title = value;
  void setDescription(String value) => description = value;
  void setDateCreational(String? value) => dateCreational = value ?? FormatDate.formatDate(FormatDate.newDate());
  void setIdTevisionTheme(int value) => idRevisionTheme = value;
  void setSync({bool? value}) => sync = value ?? false;
  void setDisable(bool value) => disable = value;
  void setInsertApp(bool value) => insertApp = value;

  static Revision fromMapToObject(Map<String, dynamic> json) => Revision(
    id: json['id'],
    title: json['title'],
    description: json['description'],
    dateCreational: json['dateCreational'],
    idRevisionTheme: json['idRevisionTheme'],
  );

  static Map<String, dynamic> fromObjectToMap(Revision revision) => {
    "id": revision.id,
    "title": revision.title,
    "description": revision.description,
    "dateCreational": revision.dateCreational,
    "idRevisionTheme": revision.idRevisionTheme,
  };
}
