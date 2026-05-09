import 'package:dio/dio.dart';
import 'package:planeje/quiz_revision/datasource/database/question_database.dart';
import 'package:planeje/quiz_revision/datasource/database/quiz_database.dart';
import 'package:planeje/quiz_revision/datasource/database/revision_quiz_database.dart';
import 'package:planeje/quiz_revision/entities/question.dart';
import 'package:planeje/quiz_revision/entities/quiz.dart';
import 'package:planeje/quiz_revision/entities/revision_quiz.dart';
import 'package:planeje/quiz_revision/utils/register_question/register_question.dart';
import 'package:planeje/quiz_revision/utils/register_quiz/find_list_quiz.dart';
import 'package:planeje/quiz_revision/utils/register_quiz/register_quiz.dart';
import 'package:planeje/quiz_revision/utils/revision_quiz/register_revision_quiz.dart';
import 'package:planeje/quiz_revision/utils/revision_quiz/revision_quiz.dart';
import 'package:planeje/sync/quiz/quiz_controller.dart';
import 'package:planeje/utils/networking/config_api.dart';
import 'package:planeje/utils/networking/endpoint.dart';
import 'package:planeje/utils/networking/endpoint/network.dart';
import 'package:planeje/utils/request_item.dart';

class QuizAync {
  Future<void> getQuiz() async {
    Response response = await Network(ConfigApi(), [Endpoint.quiz]).get();

    QuizController quizController = QuizController();

    if (response.data != null) {
      for (dynamic item in response.data) {
        Quiz quiz = Quiz.fromMapToObject(item);

        quizController.quizs.add(quiz);
      }

      await quizController.deteleTable();

      await quizController.writeQuiz();
    }
  }

  Future<void> posQuiz() async {
    List<Quiz> lists = await GetQuiz(QuizDatabase()).findAllQuizSync() ?? [];

    if (lists.isNotEmpty) {
      for (Quiz item in lists) {
        int idOld = item.id!;

        if (item.insertApp!) item.id = null;

        Response response = await Network(ConfigApi(), [Endpoint.quiz]).post(Quiz.fromObjectToMap(item));

        if (response.data != null) {
          item.sync = false;
          item.insertApp = false;
          item.id = idOld;

          await UpdateQuiz(QuizDatabase(), quiz: item).writeQuiz();

          await updateIdQuizQuestion(response.data['id'], idOld);
          await updateIdQuizRevisionQuiz(response.data['id'], idOld);
        }
      }
    }
  }

  Future<void> updateIdQuizQuestion(int id, int idOld) async {
    List<Question> questions = await GetQuestion(QuestionDatabase()).getQuestionByIdQuiz(idOld) ?? [];

    if (questions.isNotEmpty) {
      for (Question question in questions) {
        question.idQuiz = id;

        await QuestionDatabase().updateQuestion(question);
      }
    }
  }

  Future<void> updateIdQuizRevisionQuiz(int id, int idOld) async {
    List<RevisionQuiz> dateRevisions = await GetRevisionQuiz(RevisionQuizDatabase()).getRevisionQuizByIdQuiz(idOld) ?? [];

    if (dateRevisions.isNotEmpty) {
      for (RevisionQuiz dateRevision in dateRevisions) {
        dateRevision.idQuiz = id;

        await UpdateRevisionQuiz(RevisionQuizDatabase(), revisionQuiz: dateRevision).writeRevisionQuiz();
      }
    }
  }

  Future<void> posQuizDisable() async {
    List<Quiz> lists = await GetQuiz(QuizDatabase()).findQuizDisable() ?? [];

    if (lists.isNotEmpty) {
      for (Quiz item in lists) {
        Response response = await Network(ConfigApi(), [Endpoint.quiz, Endpoint.update]).post(RequestItem().convert(item));

        if (response.data != null) {
          item.sync = false;

          await UpdateQuiz(QuizDatabase(), quiz: item).writeQuiz();
        }
      }
    }
  }
}
