import 'package:floor/floor.dart';

@Entity(tableName: 'revision_theme')
class RevisionTheme {
  @PrimaryKey(autoGenerate: true)
  @ColumnInfo(name: 'id')
  int? id;

  @ColumnInfo(name: 'description')
  String? description;

  @ColumnInfo(name: 'sync')
  bool sync;

  @ColumnInfo(name: 'disable')
  bool? disable;

  @ColumnInfo(name: 'insert_app')
  bool? insertApp;

  RevisionTheme({this.id, this.description, this.sync = true, this.disable = false, this.insertApp = false});

  void setId(int? value) => id = value;
  void setDescription(String value) => description = value;
  void setSync(bool value) => sync = value;
  void setDisable(bool value) => disable = value;
  void setInsertApp(bool value) => insertApp = value;

  static RevisionTheme fromMapToObject(Map<String, dynamic> json) => RevisionTheme(id: json['id'], description: json['description'], sync: false);

  static Map<String, dynamic> fromObjectToMap(RevisionTheme revisionTheme) => {"id": revisionTheme.id, "description": revisionTheme.description};
}
