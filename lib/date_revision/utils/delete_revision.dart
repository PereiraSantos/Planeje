import 'package:planeje/revision/datasource/database/revision_database.dart';
import 'package:planeje/revision/entities/revision.dart';
import 'package:planeje/utils/delete.dart';

abstract class DeleteRevisionFactory extends DeleteFactory {}

class DeleteRevision implements DeleteRevisionFactory {
  RevisionDatabaseFactory revisionDatabase;

  DeleteRevision(this.revisionDatabase);

  @override
  Future<Revision?> disableById(int id) async {
    return await revisionDatabase.disableRevisionById(id);
  }

  @override
  Future<void> disableByIdRevision(int id) {
    throw UnimplementedError();
  }

  @override
  Future<void> deleteTable() async {
    await revisionDatabase.deleteTable();
  }
}
