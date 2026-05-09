import 'package:floor/floor.dart';
import 'package:planeje/quiz_revision/entities/revision_quiz.dart';

@dao
abstract class RevisionQuizDao {
  @Query('SELECT * FROM revision_quiz where disable = 0')
  Future<List<RevisionQuiz>?> getAllRevisionQuiz();

  @Query('SELECT * FROM revision_quiz where sync = 1 and disable = 0')
  Future<List<RevisionQuiz>?> findAllRevisionQuizSync();

  @insert
  Future<int> insertRevisionQuiz(RevisionQuiz revisionQuiz);

  @insert
  Future<void> insertRevisionQuizList(List<RevisionQuiz> revisionQuiz);

  @Query('SELECT * FROM revision_quiz WHERE id = :id and disable = 0')
  Future<RevisionQuiz?> getRevisionQuizById(int id);

  @Query('SELECT * FROM revision_quiz WHERE id_quiz = :idQuiz and disable = 0')
  Future<List<RevisionQuiz>?> getRevisionQuizByIdQuiz(int idQuiz);

  @Query('SELECT * FROM revision_quiz where disable = 1')
  Future<List<RevisionQuiz>?> findRevisionQuizDisable();

  @Query('update revision_quiz set disable = 1 WHERE id = :id')
  Future<RevisionQuiz?> disableRevisionQuiz(int id);

  @Query('update revision_quiz set disable = 1 WHERE id_quiz = :idQuiz')
  Future<void> disableRevisionQuizByIdQuiz(int idQuiz);

  @update
  Future<int> updateRevisionQuiz(RevisionQuiz revisionQuiz);

  @update
  Future<void> updateRevisionQuizList(List<RevisionQuiz> revisionQuiz);

  @Query('delete from revision_quiz')
  Future<void> deleteTable();
}
