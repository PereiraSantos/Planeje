import 'package:planeje/revision/datasource/database/date_revision_database.dart';

import 'package:planeje/revision/entities/date_revision.dart';

abstract class DateFactory {
  Future<int?> writeDateRevision();
  Future<void> writeDateRevisionList();
  DateRevision? dateRevision;
  List<DateRevision>? dateRevisions;
}

class RegisterDateRevision implements DateFactory {
  DateRevisionDatabaseFactory dateRevisionDatabase;

  RegisterDateRevision(this.dateRevisionDatabase, {this.dateRevision, this.dateRevisions});

  @override
  Future<int?> writeDateRevision() async {
    if (dateRevision == null) throw ('Teve passar um objeto dateRevision');
    return await dateRevisionDatabase.insertDateRevision(dateRevision!);
  }

  @override
  DateRevision? dateRevision;

  @override
  Future<List<int>> writeDateRevisionList() async {
    if (dateRevisions == null) throw ('Teve passar a uma lista de dateRevisions');
    return await dateRevisionDatabase.insertDateRevisionList(dateRevisions!);
  }

  @override
  List<DateRevision>? dateRevisions;
}

class UpdateDateRevision implements DateFactory {
  DateRevisionDatabaseFactory dateRevisionDatabase;

  UpdateDateRevision(this.dateRevisionDatabase, {this.dateRevision, this.dateRevisions});

  @override
  Future<int?> writeDateRevision() async {
    if (dateRevision == null) throw ('Teve passar um objeto dateRevision');
    return await dateRevisionDatabase.updateDateRevision(dateRevision!);
  }

  @override
  DateRevision? dateRevision;

  @override
  Future<void> writeDateRevisionList() async {
    if (dateRevisions == null) throw ('Teve passar a uma lista de dateRevisions');
    return await dateRevisionDatabase.updateDateRevisionList(dateRevisions!);
  }

  @override
  List<DateRevision>? dateRevisions;
}
