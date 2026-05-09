import 'package:planeje/quiz_revision/datasource/database/revision_quiz_database.dart';
import 'package:planeje/quiz_revision/entities/question.dart';
import 'package:planeje/quiz_revision/entities/revision_quiz.dart';

class ListQuestionController {
  bool isShowAnswer = false;
  int index = -1;
  RevisionQuizDatabase revisionQuizDatabase = RevisionQuizDatabase();

  set showAnswer(bool value) => isShowAnswer = value;

  bool getCheck(List<Question> list, int index) => list[index].uniqueAnswer ?? false;

  bool isAnswer(List<Question> list, bool success) {
    if (index != -1) {
      return (isShowAnswer && (list[index].uniqueAnswer ?? false) && (list[index].answer ?? false) == success);
    }
    return isShowAnswer;
  }

  void updateAnswer(int i, value, List<Question> list) {
    showAnswer = false;
    index = i;
    list.map((e) => e.uniqueAnswer = false).toList();
    list[i].uniqueAnswer = value;
  }

  Future<void> registerRevisionQuiz(List<Question> list, int index) async {
    await revisionQuizDatabase.insertRevisionQuiz(
      RevisionQuiz(idQuiz: list[index].idQuiz, answer: list[index].answer)
        ..setDate()
        ..setSync(true)
        ..setInsertApp(true),
    );
  }
}
