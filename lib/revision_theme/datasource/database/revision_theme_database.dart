import 'package:planeje/database/app_database.dart';
import 'package:planeje/revision_theme/datasource/dao/revision_theme_info_dao.dart';
import 'package:planeje/revision_theme/entities/revision_theme.dart';
import 'package:planeje/revision_theme/entities/revision_theme_complement.dart';

abstract class RevisionThemeDatabaseFactory {
  Future<List<RevisionTheme>> findAllRevisionTheme();
  Future<List<RevisionTheme>?> findAllRevisionThemeSync();
  Future<RevisionTheme?> findRevisionThemeById(int id);
  Future<RevisionTheme?> disableRevisionThemeById(int id);
  Future<List<RevisionThemeComplement>> findRevisionThemeByDescription(String text);
  Future<int> insertRevisionTheme(RevisionTheme revisionTheme);
  Future<List<int>> insertRevisionThemeList(List<RevisionTheme> revisionThemes);
  Future<int?> updateRevisionTheme(RevisionTheme revisionTheme);
  Future<int?> updateRevisionThemeList(List<RevisionTheme> revisionThemes);
  Future<List<RevisionTheme>?> findRevisionThemeDisable();
  Future<void> deleteTable();
}

class RevisionThemeDatabase implements RevisionThemeDatabaseFactory {
  @override
  Future<RevisionTheme?> disableRevisionThemeById(int id) async {
    final database = await getInstance();
    return await database.revisionThemeDao.disableRevisionThemeById(id);
  }

  @override
  Future<List<RevisionTheme>> findAllRevisionTheme() async {
    final database = await getInstance();
    return await database.revisionThemeDao.findAllRevisionTheme();
  }

  @override
  Future<List<RevisionTheme>?> findAllRevisionThemeSync() async {
    final database = await getInstance();
    return await database.revisionThemeDao.findAllRevisionThemeSync();
  }

  @override
  Future<List<RevisionThemeComplement>> findRevisionThemeByDescription(String text) async {
    final database = await getInstance();
    return await RevisionThemeInfoDao().findRevisionThemeById(database, text);
  }

  @override
  Future<RevisionTheme?> findRevisionThemeById(int id) async {
    final database = await getInstance();
    return await database.revisionThemeDao.findRevisionThemeById(id);
  }

  @override
  Future<int> insertRevisionTheme(RevisionTheme revisionTheme) async {
    final database = await getInstance();
    return await database.revisionThemeDao.insertRevisionTheme(revisionTheme);
  }

  @override
  Future<List<int>> insertRevisionThemeList(List<RevisionTheme> revisionThemes) async {
    final database = await getInstance();
    return await database.revisionThemeDao.insertRevisionThemeList(revisionThemes);
  }

  @override
  Future<int?> updateRevisionTheme(RevisionTheme revisionTheme) async {
    final database = await getInstance();
    return await database.revisionThemeDao.updateRevisionTheme(revisionTheme);
  }

  @override
  Future<int?> updateRevisionThemeList(List<RevisionTheme> revisionThemes) async {
    final database = await getInstance();
    return await database.revisionThemeDao.updateRevisionThemeList(revisionThemes);
  }

  @override
  Future<List<RevisionTheme>?> findRevisionThemeDisable() async {
    final database = await getInstance();
    return await database.revisionThemeDao.findRevisionThemeDisable();
  }

  @override
  Future<void> deleteTable() async {
    final database = await getInstance();
    return await database.revisionThemeDao.deleteTable();
  }
}
