import 'package:floor/floor.dart';
import 'package:planeje/revision/entities/revision.dart';

@dao
abstract class RevisionDao {
  @Query('SELECT * FROM revision')
  Future<List<Revision>> findAllRevisions();

  @Query('SELECT * FROM revision where sync = 1 and disable = 0')
  Future<List<Revision>?> findAllRevisionsSync();

  @Query('SELECT * FROM revision WHERE id = :id')
  Future<Revision?> findRevisionById(int id);

  @Query('update revision set disable = 1 WHERE id = :id')
  Future<Revision?> disableRevisionById(int id);

  @Query('SELECT * FROM revision WHERE text LIKE :text')
  Future<List<Revision>> findRevisionByDescription(String text);

  @Query('SELECT * FROM revision where id_revision_theme = :idRevisionTheme and disable = 0')
  Future<List<Revision>?> findRevisioByIdRevisionTheme(int idRevisionTheme);

  @Query('SELECT * FROM revision where  disable = 1')
  Future<List<Revision>?> findRevisionDisable();

  @insert
  Future<int> insertRevision(Revision revision);

  @insert
  Future<List<int>> insertRevisionList(List<Revision> revision);

  @update
  Future<int?> updateRevision(Revision revision);

  @update
  Future<void> updateRevisionList(List<Revision> revision);

  @Query('delete from revision')
  Future<void> deleteTable();
}
