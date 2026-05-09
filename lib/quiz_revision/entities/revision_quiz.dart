import 'package:floor/floor.dart';
import 'package:planeje/utils/format_date.dart';

@Entity(tableName: 'revision_quiz')
class RevisionQuiz {
  @PrimaryKey(autoGenerate: true)
  @ColumnInfo(name: 'id')
  int? id;

  @ColumnInfo(name: 'date_revision')
  String? dateRevision;

  @ColumnInfo(name: 'answer')
  bool? answer;

  @ColumnInfo(name: 'id_quiz')
  int? idQuiz;

  @ColumnInfo(name: 'sync')
  bool sync;

  @ColumnInfo(name: 'disable')
  bool? disable;

  @ColumnInfo(name: 'insert_app')
  bool? insertApp;

  RevisionQuiz({this.id, this.dateRevision, this.answer, this.idQuiz, this.sync = true, this.disable = false, this.insertApp = false});

  void setId(int? value) => id = value;
  void setDate({String? value}) => dateRevision = value ?? FormatDate.formatDateTime(DateTime.now());
  void setAnswer(bool? value) => answer = value;
  void setIdQuiz(int? value) => idQuiz = value;
  void setSync(bool value) => sync = value;
  void setDisable(bool value) => disable = value;
  void setInsertApp(bool value) => insertApp = value;

  static RevisionQuiz fromMapToObject(Map<String, dynamic> json) =>
      RevisionQuiz(id: json['id'], dateRevision: json['dateRevision'], answer: json['answer'] == 1, idQuiz: json['idQuiz'], sync: false);

  static Map<String, dynamic> fromObjectToMap(RevisionQuiz revisionQuiz) => {
    "id": revisionQuiz.id,
    "answer": (revisionQuiz.answer ?? false) ? 1 : 0,
    "dateRevision": revisionQuiz.dateRevision,
    "idQuiz": revisionQuiz.idQuiz,
  };
}
