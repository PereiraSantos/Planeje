import 'package:planeje/revision_theme/datasource/database/revision_theme_database.dart';
import 'package:planeje/revision_theme/entities/revision_theme.dart';

abstract class RevisionThemeFactory {
  Future<int?> write(RevisionTheme revisionTheme);
}

class InsertRevisioTheme implements RevisionThemeFactory {
  final RevisionThemeDatabaseFactory _revisionThemeDatabase;

  InsertRevisioTheme(this._revisionThemeDatabase);

  @override
  Future<int> write(RevisionTheme revisionTheme) async {
    return await _revisionThemeDatabase.insertRevisionTheme(revisionTheme);
  }

  Future<List<int>> writeList(List<RevisionTheme> revisionThemes) async {
    return await _revisionThemeDatabase.insertRevisionThemeList(revisionThemes);
  }
}
