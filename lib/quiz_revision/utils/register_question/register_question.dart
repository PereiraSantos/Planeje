import 'package:planeje/quiz_revision/datasource/database/question_database.dart';
import 'package:planeje/quiz_revision/entities/question.dart';
import 'package:planeje/quiz_revision/utils/register_question/question_list.dart';

abstract class RegisterQuestionFactory {
  Future<bool> writeQuestion(List<QuestionList> questionList);
  Future<void> writeQuestionList();
  List<Question>? questions;
}

abstract class FindQuestion {
  Future<List<Question>?> getAllQuestion();
  Future<Question?> getQuestionById(int id);
  Future<List<Question>?> getQuestionByIdQuiz(int idQuiz);
  Future<List<Question>?> findAllQuestionSync();
  Future<List<Question>?> findQuestionDisable();
}

class SaveQuestion implements RegisterQuestionFactory {
  QuestionDatabaseFactory questionDatabase;

  SaveQuestion(this.questionDatabase, {this.questions});

  @override
  Future<bool> writeQuestion(List<QuestionList> questionList) async {
    for (var item in questionList) {
      item.question?.sync = true;
      item.question?.insertApp = true;

      if (item.add) await questionDatabase.insertQuestion(item.question!);
      if (item.update) await questionDatabase.updateQuestion(item.question!);
    }
    return true;
  }

  @override
  Future<void> writeQuestionList() async {
    await questionDatabase.insertQuestionList(questions!);
  }

  @override
  List<Question>? questions;
}

class UpdateQuestion implements RegisterQuestionFactory {
  QuestionDatabaseFactory questionDatabase;

  UpdateQuestion(this.questionDatabase, {this.questions});

  @override
  Future<bool> writeQuestion(List<QuestionList> questionList) async {
    for (var item in questionList) {
      if (item.add) await questionDatabase.insertQuestion(item.question!);
      if (item.update) await questionDatabase.updateQuestion(item.question!);
    }
    return true;
  }

  @override
  Future<void> writeQuestionList() async {
    await questionDatabase.updateQuestionList(questions!);
  }

  @override
  List<Question>? questions;
}

class GetQuestion implements FindQuestion {
  QuestionDatabaseFactory questionDatabase;

  GetQuestion(this.questionDatabase);
  @override
  Future<List<Question>?> getAllQuestion() async {
    return await questionDatabase.getAllQuestion();
  }

  @override
  Future<Question?> getQuestionById(int id) async {
    return await questionDatabase.getQuestionById(id);
  }

  @override
  Future<List<Question>?> getQuestionByIdQuiz(int idQuiz) async {
    return await questionDatabase.getQuestionByIdQuiz(idQuiz);
  }

  @override
  Future<List<Question>?> findAllQuestionSync() async {
    return await questionDatabase.findAllQuestionSync();
  }

  @override
  Future<List<Question>?> findQuestionDisable() async {
    return await questionDatabase.findQuestionDisable();
  }
}
