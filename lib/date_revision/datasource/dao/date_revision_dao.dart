import 'package:floor/floor.dart';
import 'package:planeje/revision/entities/date_revision.dart';

@dao
abstract class DateRevisionDao {
  @Query('SELECT * FROM date_revision')
  Future<List<DateRevision>> findAllRevisions();

  @Query('SELECT * FROM date_revision where sync = 0 and disable = 0')
  Future<List<DateRevision>?> findAllDateRevisionSync();

  @Query('SELECT * FROM date_revision where disable = 1')
  Future<List<DateRevision>?> findDateRevisionDisable();

  @Query('SELECT * FROM date_revision where id_revision = :idRevision and disable = 0')
  Future<List<DateRevision>?> findDateRevisionByIdRevision(int idRevision);

  @Query('update date_revision set disable = 1 WHERE id = :id')
  Future<DateRevision?> disableDateRevisionById(int id);

  @Query('update date_revision set disable = 1 WHERE id_revision = :idRevision')
  Future<DateRevision?> disableDateRevisionByIdRevision(int idRevision);

  @update
  Future<int?> updateDateRevision(DateRevision dateRevision);

  @insert
  Future<int?> insertDateRevision(DateRevision dateRevision);

  @insert
  Future<List<int>> insertDateRevisionList(List<DateRevision> dateRevision);

  @Query('update date_revision set hour_init = :hourInit where id_date = :id')
  Future<void> updateHourInitRevision(String hourInit, int id);

  @Query('update date_revision set date_revision = :dateRevision, next_date_revision = :nextDateRevision, hour_end = :hourEnd where id_date = :id')
  Future<void> updateHourEndRevision(String hourEnd, String dateRevision, String nextDateRevision, int id);

  @Query('update date_revision set status = :status where id_date = :id')
  Future<void> updateStatus(bool status, int id);

  @Query(' select * from date_revision  where id_date = :id')
  Future<DateRevision?> findDateRevisionById(int id);

  @update
  Future<void> updateDateRevisionList(List<DateRevision> dateRevision);

  @Query('delete from date_revision')
  Future<void> deleteTable();
}
