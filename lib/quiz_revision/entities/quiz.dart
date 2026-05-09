import 'package:floor/floor.dart';

@Entity(tableName: 'quiz')
class Quiz {
  @PrimaryKey(autoGenerate: true)
  @ColumnInfo(name: 'id')
  int? id;

  @ColumnInfo(name: 'topic')
  String? topic;

  @ColumnInfo(name: 'description')
  String? description;

  @ColumnInfo(name: 'sync')
  bool sync;

  @ColumnInfo(name: 'disable')
  bool? disable;

  @ColumnInfo(name: 'insert_app')
  bool? insertApp;

  Quiz({this.id, this.topic, this.description, this.sync = true, this.disable = false, this.insertApp = false});

  void setId(int? value) => id = value;
  void setTopic(String? value) => topic = value;
  void setDescription(String? value) => description = value;
  void setSync(bool value) => sync = value;
  void setDisable(bool value) => disable = value;
  void setInsertApp(bool value) => insertApp = value;

  static Quiz fromMapToObject(Map<String, dynamic> json) => Quiz(id: json['id'], topic: json['topic'], description: json['description'], sync: false);

  static Map<String, dynamic> fromObjectToMap(Quiz quiz) => {"id": quiz.id, "topic": quiz.topic, "description": quiz.description};
}
