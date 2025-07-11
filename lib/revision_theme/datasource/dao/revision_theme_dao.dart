import 'package:floor/floor.dart';
import 'package:planeje/revision_theme/entities/revision_theme.dart';

@dao
abstract class RevisionThemeDao {
  @Query('SELECT * FROM revision_theme')
  Future<List<RevisionTheme>> findAllRevisionTheme();

  @Query('SELECT * FROM revision_theme where sync = 0 and disable = 0')
  Future<List<RevisionTheme>?> findAllRevisionThemeSync();

  @Query('SELECT * FROM revision_theme where disable = 1')
  Future<List<RevisionTheme>?> findRevisionThemeDisable();

  @Query('SELECT * FROM revision_theme WHERE id = :id')
  Future<RevisionTheme?> findRevisionThemeById(int id);

  @Query('update revision_theme set disable = 1 WHERE id = :id')
  Future<RevisionTheme?> disableRevisionThemeById(int id);

  @Query('SELECT * FROM revision_theme WHERE description LIKE :text')
  Future<List<RevisionTheme>> findRevisionThemeByDescription(String text);

  @insert
  Future<int> insertRevisionTheme(RevisionTheme revisionTheme);

  @insert
  Future<List<int>> insertRevisionThemeList(List<RevisionTheme> revisionThemes);

  @update
  Future<int?> updateRevisionTheme(RevisionTheme revisionTheme);

  @update
  Future<int?> updateRevisionThemeList(List<RevisionTheme> revisionThemes);

  @Query('delete from revision_theme')
  Future<void> deleteTable();
}
