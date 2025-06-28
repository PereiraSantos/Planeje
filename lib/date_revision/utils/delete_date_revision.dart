import 'package:planeje/revision/datasource/database/date_revision_database.dart';

abstract class DeleteDateRevisionFactory {
  Future<void> disableDateRevisionByIdRevision(int idRevision);
  Future<void> deleteTable();
}

class DeleteDateRevision implements DeleteDateRevisionFactory {
  DateRevisionDatabaseFactory dateRevisionDatabaseFactory;

  DeleteDateRevision(this.dateRevisionDatabaseFactory);

  @override
  Future<void> disableDateRevisionByIdRevision(int idRevision) async {
    return await dateRevisionDatabaseFactory.disableDateRevisionByIdRevision(idRevision);
  }

  @override
  Future<void> deleteTable() async {
    await dateRevisionDatabaseFactory.deleteTable();
  }
}
