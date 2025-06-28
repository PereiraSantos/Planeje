import 'package:planeje/revision/datasource/database/date_revision_database.dart';
import 'package:planeje/revision/entities/date_revision.dart';

abstract class FindDateRevisionFactory {
  Future<List<DateRevision>> findAllDateRevisions();
  Future<List<DateRevision>?> findAllDateRevisionSync();
  Future<List<DateRevision>?> findDateRevisionDisable();
  Future<List<DateRevision>?> findDateRevisionByIdRevision(int idRevision);
}

class GetDateRevision implements FindDateRevisionFactory {
  DateRevisionDatabaseFactory dateRevisionDatabase;

  GetDateRevision(this.dateRevisionDatabase);

  @override
  Future<List<DateRevision>> findAllDateRevisions() async {
    return await dateRevisionDatabase.findAllDateRevisions();
  }

  @override
  Future<List<DateRevision>?> findAllDateRevisionSync() async {
    return await dateRevisionDatabase.findAllDateRevisionSync();
  }

  @override
  Future<List<DateRevision>?> findDateRevisionDisable() async {
    return await dateRevisionDatabase.findDateRevisionDisable();
  }

  @override
  Future<List<DateRevision>?> findDateRevisionByIdRevision(int idRevision) async {
    return await dateRevisionDatabase.findDateRevisionByIdRevision(idRevision);
  }
}
