import 'package:planeje/revision/datasource/database/date_revision_database.dart';

abstract class UpdateHourFactory {
  Future<void> updateHourInit(String hourInit, int id);
  Future<void> updateHourEnd(String hourEnd, String dateRevision, String nextDateRevision, int id);
  Future<void> updateStatus(bool status, int id);
}

class UpdateHour implements UpdateHourFactory {
  DateRevisionDatabase dataSourceRepository;

  UpdateHour(this.dataSourceRepository);
  @override
  Future<void> updateHourEnd(String hourEnd, String dateRevision, String nextDateRevision, int id) async {
    await dataSourceRepository.updateHourEnd(hourEnd, dateRevision, nextDateRevision, id);
  }

  @override
  Future<void> updateHourInit(String hourInit, int id) async {
    await dataSourceRepository.updateHourInit(hourInit, id);
  }

  @override
  Future<void> updateStatus(bool status, int id) async {
    await dataSourceRepository.updateStatus(status, id);
  }
}
