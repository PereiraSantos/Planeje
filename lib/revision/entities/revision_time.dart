import 'package:planeje/revision/entities/date_revision.dart';
import 'package:planeje/revision/entities/revision.dart';

class RevisionTime {
  Revision revision;
  DateRevision dateRevision;
  String? date;

  RevisionTime(this.revision, this.dateRevision, this.date);
}
