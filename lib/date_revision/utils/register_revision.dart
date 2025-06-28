import 'package:planeje/revision/datasource/database/revision_database.dart';
import 'package:planeje/revision/entities/revision.dart';
import 'package:planeje/revision/utils/register_date_revision.dart';
import 'package:planeje/utils/register.dart';
import 'package:planeje/utils/type_message.dart';

abstract class RevisionFactory extends RegisterFactory {
  Revision? revision;
  List<Revision>? revisions = [];
  DateFactory? registerDate;
}

class Register implements RevisionFactory {
  RevisionDatabaseFactory revisionDatabase;

  Register(this.revisionDatabase, {this.registerDate, this.revision, this.message, this.revisions});

  @override
  Future<int?> write() async {
    if (revision == null) throw ('Teve passar um objeto revision');
    return await revisionDatabase.insertRevision(revision!);
  }

  @override
  Revision? revision;

  @override
  StatusNotification? message;

  @override
  DateFactory? registerDate;

  @override
  Future writeList() async {
    if (revisions == null) throw ('Teve passar a uma lista de revisions');
    return await revisionDatabase.insertRevisionList(revisions!);
  }

  @override
  List<Revision>? revisions;
}

class Update implements RevisionFactory {
  RevisionDatabase revisionDatabase;

  Update(this.revisionDatabase, {this.revision, this.message, this.registerDate, this.revisions});

  @override
  Revision? revision;

  @override
  Future<int?> write() async {
    if (revision == null) throw ('Teve passar um objeto revision');
    return await revisionDatabase.updateRevision(revision!);
  }

  @override
  StatusNotification? message;

  @override
  DateFactory? registerDate;

  @override
  Future writeList() async {
    if (revisions == null) throw ('Teve passar a uma lista de revisions');
    return await revisionDatabase.updateRevisionList(revisions!);
  }

  @override
  List<Revision>? revisions;
}
