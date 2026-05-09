import 'package:floor/floor.dart';
import 'package:planeje/annotation/entities/annotation.dart';

@dao
abstract class AnnotationDao {
  @insert
  Future<int?> insertAnnotation(Annotation annotationEntity);

  @insert
  Future<List<int>> insertAnnotationList(List<Annotation> annotationEntity);

  @update
  Future<int?> updateAnnotation(Annotation annotationEntity);

  @Query('update annotation set disable = 1 where id = :id')
  Future<void> disable(int id);

  @Query('update annotation set disable = 1 where id_revision = :idRevision')
  Future<void> disableByIdRevision(int idRevision);

  @Query('select * from annotation where id_revision = :idRevision and disable = 0')
  Future<List<Annotation>?> getAnnotationWidthIdRevision(int idRevision);

  @Query('select * from annotation where and disable = 0')
  Future<List<Annotation>?> getAnnotationAll();

  @Query('select * from annotation where sync = 1 and disable = 0')
  Future<List<Annotation>?> findAnnotationSync();

  @Query('SELECT * FROM annotation where disable = 1')
  Future<List<Annotation>?> findAnnotationDisable();

  @Query('delete from annotation')
  Future<void> deleteTable();

  @update
  Future<void> updateAnnotationList(List<Annotation> annotation);
}
