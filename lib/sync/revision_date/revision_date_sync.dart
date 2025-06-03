import 'package:dio/dio.dart';
import 'package:planeje/revision/datasource/database/date_revision_database.dart';
import 'package:planeje/revision/entities/date_revision.dart';
import 'package:planeje/revision/utils/find_date_revision.dart';
import 'package:planeje/revision/utils/register_date_revision.dart';
import 'package:planeje/sync/revision_date/revision_date_controller.dart';
import 'package:planeje/utils/networking/config_api.dart';
import 'package:planeje/utils/networking/endpoint.dart';
import 'package:planeje/utils/networking/endpoint/network.dart';
import 'package:planeje/utils/request_item.dart';

class RevisionDateSync {
  Future<bool> getRevisionDate() async {
    Response response = await Network(ConfigApi(), [Endpoint.revision, Endpoint.date]).get();

    RevisionDateController revisionDateController = RevisionDateController();

    if (response.data != null) {
      for (dynamic item in response.data) {
        DateRevision dateRevision = DateRevision.fromMapToObject(item);

        revisionDateController.revisionDates.add(dateRevision);
      }

      await revisionDateController.deteleTable();

      await revisionDateController.writeRevisionData();
    }
    return true;
  }

  Future<bool> postRevisionDate() async {
    List<DateRevision>? lists = await GetDateRevision(DateRevisionDatabase()).findAllDateRevisionSync() ?? [];

    if (lists.isNotEmpty) {
      for (DateRevision item in lists) {
        if (item.insertApp!) item.id = null;

        Response response = await Network(ConfigApi(), [Endpoint.revision, Endpoint.date]).post(DateRevision.fromObjectToMap(item));

        if (response.data != null) {
          item.sync = true;

          await UpdateDateRevision(DateRevisionDatabase(), dateRevision: item).writeDateRevision();
        }
      }
    }
    return true;
  }

  Future<bool> postRevisionDateDisable() async {
    List<DateRevision>? lists = await GetDateRevision(DateRevisionDatabase()).findDateRevisionDisable() ?? [];

    if (lists.isNotEmpty) {
      for (DateRevision item in lists) {
        Response response = await Network(ConfigApi(), [Endpoint.revision, Endpoint.date, Endpoint.update]).post(RequestItem().convert(item));

        if (response.data != null) {
          item.sync = true;

          await UpdateDateRevision(DateRevisionDatabase(), dateRevision: item).writeDateRevision();
        }
      }
    }
    return true;
  }
}
