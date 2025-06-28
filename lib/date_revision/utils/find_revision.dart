import 'package:planeje/revision/datasource/database/revision_database.dart';
import 'package:planeje/revision/entities/revision.dart';
import 'package:planeje/revision/entities/revision_time.dart';

abstract class FindRevisionFactory {
  Future<List<RevisionTime>> findRevisionByDescription(String text, int id, bool isBefore, {int? limit});
  Future<int> getQuantiyRevision(String date, bool isBefore);
  Future<List<Revision>> findAllRevisions();
  Future<List<Revision>?> findAllRevisionsSync();
  Future<List<Revision>?> findRevisioByIdRevisionTheme(int idRevisionTheme);
  Future<List<Revision>?> findRevisionDisable();
}

class GetRevision implements FindRevisionFactory {
  RevisionDatabaseFactory revisionDatabase;

  GetRevision(this.revisionDatabase);
  @override
  Future<List<RevisionTime>> findRevisionByDescription(String text, int id, bool isBefore, {int? limit}) async {
    return await revisionDatabase.findRevisionByDescription(text, id, isBefore, limit: limit);
  }

  @override
  Future<int> getQuantiyRevision(String date, bool isBefore) async {
    return await revisionDatabase.getQuantiyRevision(date, isBefore);
  }

  @override
  Future<List<Revision>> findAllRevisions() async {
    return await revisionDatabase.findAllRevisions();
  }

  @override
  Future<List<Revision>?> findAllRevisionsSync() async {
    return await revisionDatabase.findAllRevisionsSync();
  }

  @override
  Future<List<Revision>?> findRevisioByIdRevisionTheme(int idRevisionTheme) async {
    return await revisionDatabase.findRevisioByIdRevisionTheme(idRevisionTheme);
  }

  @override
  Future<List<Revision>?> findRevisionDisable() async {
    return await revisionDatabase.findRevisionDisable();
  }
}
