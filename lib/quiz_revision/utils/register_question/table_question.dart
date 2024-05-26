import 'package:flutter/material.dart';
import 'package:planeje/quiz_revision/datasource/database/question_database.dart';
import 'package:planeje/quiz_revision/entities/question.dart';
import 'package:planeje/quiz_revision/utils/register_question/question_list.dart';
import 'package:planeje/quiz_revision/utils/register_question/register_question.dart';
import 'package:planeje/quiz_revision/utils/register_question/remove_question.dart';
import 'package:planeje/utils/message.dart';

class TableQuestionNotifier with ChangeNotifier {
  RegisterQuestion registerQuestion = SaveQuestion(QuestionDatabase());
  List<QuestionList> questions = [];

  void deleteQuestionByIdQuiz(int idQUiz) async {
    List<Question>? list = await GetQuestion(QuestionDatabase()).getQuestionByIdQuiz(idQUiz) ?? [];
    for (var question in list) {
      questions.add(QuestionList(delete: true, question: question));
    }
  }

  void addQuestion(Question question) {
    questions.add(QuestionList(add: true, question: question));
    notifyListeners();
  }

  void deleteQuestion(int i) {
    questions[i].delete = true;
    notifyListeners();
  }

  void updateAnwser(int index, value) {
    questions.map((e) => e.question!.answer = false).toList();
    questions[index].question!.answer = value;
    notifyListeners();
  }

  Future<void> updateIdQuiz(int id) async {
    questions.map((e) {
      if (e.question!.idQuiz == null) return e.question!.idQuiz = id;
    }).toList();

    await registerQuestion.writeQuestion(questions);
    DeleteQuestion deleteQuestion = RemoveQuestion(QuestionDatabase());
    await deleteQuestion.delete(questions);
  }

  bool listQuestionuestionIsEmpty(BuildContext context) {
    if (questions.isNotEmpty) return true;
    Message.message(context, 'Obrigatório adicionar registro');
    return false;
  }

  bool isAnwserByListQuestion(BuildContext context) {
    if (_isAnwser()) return true;
    Message.message(context, 'Obrigatório marcar uma resposta');
    return false;
  }

  bool _isAnwser() => questions.where((element) => element.question!.answer!).toList().isNotEmpty;

  Future<void> initListQuestionEdit(int? idQUiz) async {
    if (idQUiz == null) return;

    questions = [];
    List<Question> list = await GetQuestion(QuestionDatabase()).getQuestionByIdQuiz(idQUiz) ?? [];

    for (var question in list) {
      questions.add(QuestionList(update: true, question: question));
    }

    notifyListeners();
  }
}
