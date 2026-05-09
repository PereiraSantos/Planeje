import 'package:floor/floor.dart';
import 'package:planeje/quiz_revision/entities/quiz.dart';

@dao
abstract class QuizDao {
  @Query('SELECT * FROM quiz where disable = 0')
  Future<List<Quiz>?> getAllQuiz();

  @Query('SELECT * FROM quiz where sync = 1 and disable = 0')
  Future<List<Quiz>?> findAllQuizSync();

  @Query('SELECT * FROM quiz where topic LIKE :text and disable = 0')
  Future<List<Quiz>?> getAllQuizSearch(String text);

  @Query('SELECT * FROM quiz where disable = 1')
  Future<List<Quiz>?> findQuizDisable();

  @insert
  Future<int> insertQuiz(Quiz quiz);

  @insert
  Future<List<int>> insertQuizList(List<Quiz> quiz);

  @Query('SELECT * FROM quiz WHERE id = :id')
  Future<Quiz?> getQuizById(int id);

  @Query('update quiz set disable = 1 WHERE id = :id')
  Future<Quiz?> disableQuiz(int id);

  @update
  Future<int> updateQuiz(Quiz quiz);

  @update
  Future<void> updateQuizList(List<Quiz> quiz);

  @Query('delete from quiz')
  Future<void> deleteTable();
}
