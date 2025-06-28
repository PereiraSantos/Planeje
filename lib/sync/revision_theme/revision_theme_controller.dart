import 'package:planeje/revision_theme/datasource/database/revision_theme_database.dart';
import 'package:planeje/revision_theme/entities/revision_theme.dart';
import 'package:planeje/revision_theme/utils/delete_revision_theme.dart';
import 'package:planeje/revision_theme/utils/insert_revision_theme.dart';

class RevisionThemeController {
  List<RevisionTheme> revisionThemes = [];

  Future<bool> writeRevisionTheme() async {
    if (revisionThemes.isNotEmpty) await InsertRevisioTheme(RevisionThemeDatabase()).writeList(revisionThemes);

    return true;
  }

  Future<void> deteleTable() async => await DeleteRevisionTheme(RevisionThemeDatabase()).deleteTable();
}
