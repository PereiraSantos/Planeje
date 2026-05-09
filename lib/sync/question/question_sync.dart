import 'package:dio/dio.dart';
import 'package:planeje/quiz_revision/datasource/database/question_database.dart';
import 'package:planeje/quiz_revision/entities/question.dart';
import 'package:planeje/quiz_revision/utils/register_question/register_question.dart';
import 'package:planeje/sync/question/question_controller.dart';
import 'package:planeje/utils/networking/config_api.dart';
import 'package:planeje/utils/networking/endpoint.dart';
import 'package:planeje/utils/networking/endpoint/network.dart';
import 'package:planeje/utils/request_item.dart';

class QuestionSync {
  Future<void> getQuestion() async {
    Response response = await Network(ConfigApi(), [Endpoint.question]).get();

    QuestionController questionController = QuestionController();

    if (response.data != null) {
      for (dynamic item in response.data) {
        Question question = Question.fromMapToObject(item);

        questionController.questions.add(question);
      }

      await questionController.deleteTable();

      await questionController.writeQuestion();
    }
  }

  Future<void> postQuestion() async {
    List<Question> lists = await GetQuestion(QuestionDatabase()).findAllQuestionSync() ?? [];

    if (lists.isNotEmpty) {
      for (Question item in lists) {
        int idOld = item.id!;

        if (item.insertApp!) item.id = null;

        Response response = await Network(ConfigApi(), [Endpoint.question]).post(Question.fromObjectToMap(item));

        if (response.data != null) {
          item.sync = false;
          item.insertApp = false;
          item.id = idOld;

          await QuestionDatabase().updateQuestion(item);
        }
      }
    }
  }

  Future<void> postQuestionDisable() async {
    List<Question> lists = await GetQuestion(QuestionDatabase()).findQuestionDisable() ?? [];

    if (lists.isNotEmpty) {
      for (Question item in lists) {
        Response response = await Network(ConfigApi(), [Endpoint.question, Endpoint.update]).post(RequestItem().convert(item));

        if (response.data != null) {
          item.sync = false;

          await QuestionDatabase().updateQuestion(item);
        }
      }
    }
  }
}
