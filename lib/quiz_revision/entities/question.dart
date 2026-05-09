import 'package:floor/floor.dart';

@Entity(tableName: 'question')
class Question {
  @PrimaryKey(autoGenerate: true)
  @ColumnInfo(name: 'id')
  int? id;

  @ColumnInfo(name: 'id_quiz')
  int? idQuiz;

  @ColumnInfo(name: 'description')
  String? description;

  @ColumnInfo(name: 'answer')
  bool? answer;

  @ColumnInfo(name: 'sync')
  bool sync;

  @ColumnInfo(name: 'disable')
  bool? disable;

  @ColumnInfo(name: 'insert_app')
  bool? insertApp;

  @ignore
  bool? uniqueAnswer;

  Question({this.id, this.idQuiz, this.description, this.answer = false, this.uniqueAnswer, this.sync = true, this.disable = false, this.insertApp = false});

  void setId(int? value) => id = value;
  void setIdQuiz(int? value) => idQuiz = id;
  void setDescription(String? value) => description = value;
  void setAnswer(bool? value) => answer = value;
  void setUniqueAnswer(bool? value) => uniqueAnswer = value;
  void setSync(bool value) => sync = value;
  void setDisable(bool value) => disable = value;
  void setInsertApp(bool value) => insertApp = value;

  static Question fromMapToObject(Map<String, dynamic> json) => Question(
    id: json['id'],
    idQuiz: json['idQuiz'],
    description: json['description'],
    answer: json['answer'] == 1,
    uniqueAnswer: json['uniqueAnswer'],
    sync: false,
  );

  static Map<String, dynamic> fromObjectToMap(Question question) => {
    "id": question.id,
    "idQuiz": question.idQuiz,
    "description": question.description,
    "answer": (question.answer ?? false) ? 1 : 0,
    "uniqueAnswer": question.uniqueAnswer,
  };
}
