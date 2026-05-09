import 'package:floor/floor.dart';
import 'package:planeje/utils/format_date.dart';

@Entity(tableName: 'annotation')
class Annotation {
  @PrimaryKey(autoGenerate: true)
  int? id;

  @ColumnInfo(name: 'title')
  String? title;

  @ColumnInfo(name: 'text')
  String? text;

  @ColumnInfo(name: 'date_text')
  String? dateText;

  @ColumnInfo(name: 'id_revision')
  int? idRevision;

  @ColumnInfo(name: 'sync')
  bool sync;

  @ColumnInfo(name: 'disable')
  bool? disable;

  @ColumnInfo(name: 'insert_app')
  bool? insertApp;

  Annotation({this.id, this.title, this.text, this.dateText, this.idRevision, this.sync = true, this.disable = false, this.insertApp = false});

  void setId(int? value) => id = value;
  void setTitle(String value) => title = value;
  void setText(String value) => text = value;
  void setDateText(String? date) => dateText = date ?? FormatDate.formatDate(FormatDate.newDate());
  void setIdRevision(int? value) => idRevision = value;
  void setSync(bool value) => sync = value;
  void setDisable(bool value) => disable = value;
  void setInsertApp(bool value) => insertApp = value;

  static Annotation fromMapToObject(Map<String, dynamic> json) =>
      Annotation(id: json['id'], title: json['title'], text: json['text'], dateText: json['dateText'], idRevision: json['idRevision'], sync: false);

  static Map<String, dynamic> fromObjectToMap(Annotation annotation) => {
    "id": annotation.id,
    "title": annotation.title,
    "text": annotation.text,
    "dateText": annotation.dateText,
    "idRevision": annotation.idRevision,
  };
}
