import 'package:planeje/revision_theme/datasource/database/revision_theme_database.dart';
import 'package:planeje/revision_theme/entities/revision_theme.dart';
import 'package:planeje/revision_theme/utils/insert_revision_theme.dart';

class UpdateRevisionTheme implements RevisionThemeFactory {
  final RevisionThemeDatabaseFactory _revisionThemeDatabase;

  UpdateRevisionTheme(this._revisionThemeDatabase);

  @override
  Future<int?> write(RevisionTheme revisionTheme) async {
    return await _revisionThemeDatabase.updateRevisionTheme(revisionTheme);
  }
}
