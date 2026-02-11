import 'package:planeje/revision_theme/entities/revision_theme.dart';

class RevisionThemeComplement extends RevisionTheme {
  String? revisionDescription;
  String? title;
  String? dateRevision;
  String? nextDateRevision;

  RevisionThemeComplement(this.revisionDescription, this.title, this.dateRevision, this.nextDateRevision, int id, String description, bool sync)
    : super(id: id, description: description, sync: sync);
}
