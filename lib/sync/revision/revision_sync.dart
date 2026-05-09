import 'package:dio/dio.dart';
import 'package:planeje/annotation/datasource/database/annotation_database.dart';
import 'package:planeje/annotation/entities/annotation.dart';
import 'package:planeje/annotation/utils/find_annotation.dart';
import 'package:planeje/annotation/utils/register_annotation.dart';
import 'package:planeje/revision/datasource/database/date_revision_database.dart';
import 'package:planeje/revision/datasource/database/revision_database.dart';
import 'package:planeje/revision/entities/date_revision.dart';
import 'package:planeje/revision/entities/revision.dart';
import 'package:planeje/revision/utils/find_date_revision.dart';
import 'package:planeje/revision/utils/find_revision.dart';
import 'package:planeje/revision/utils/register_date_revision.dart';
import 'package:planeje/revision/utils/register_revision.dart';
import 'package:planeje/sync/revision/revision_controller.dart';
import 'package:planeje/utils/networking/config_api.dart';
import 'package:planeje/utils/networking/endpoint.dart';
import 'package:planeje/utils/networking/endpoint/network.dart';
import 'package:planeje/utils/request_item.dart';

class RevisionSync {
  Future<void> getRevision() async {
    Response response = await Network(ConfigApi(), [Endpoint.revision]).get();

    RevisionController revisionController = RevisionController();

    if (response.data != null) {
      for (dynamic item in response.data) {
        Revision revision = Revision.fromMapToObject(item);

        revisionController.revisions.add(revision);
      }

      await revisionController.deleteTable();

      await revisionController.writeRevision();
    }
  }

  Future<void> postRevision() async {
    List<Revision>? lists = await GetRevision(RevisionDatabase()).findAllRevisionsSync() ?? [];

    if (lists.isNotEmpty) {
      for (Revision item in lists) {
        int idOld = item.id!;

        if (item.insertApp!) item.id = null;

        Response response = await Network(ConfigApi(), [Endpoint.revision]).post(Revision.fromObjectToMap(item));

        if (response.data != null) {
          item.sync = false;
          item.insertApp = false;
          item.id = idOld;

          await Update(RevisionDatabase(), revision: item).write();

          await updateIdRevisionAnnotation(response.data['id'], idOld);
          await updateIdRevisionDate(response.data['id'], idOld);
        }
      }
    }
  }

  Future<void> updateIdRevisionAnnotation(int id, int idOld) async {
    List<Annotation> annotations = await GetAnnotation(AnnotationDatabase()).getAnnotationWidthIdRevision(idOld) ?? [];

    if (annotations.isNotEmpty) {
      for (Annotation annotation in annotations) {
        annotation.idRevision = id;

        await UpdateAnnotation(AnnotationDatabase(), annotation: annotation).write();
      }
    }
  }

  Future<void> updateIdRevisionDate(int id, int idOld) async {
    List<DateRevision> dateRevisions = await GetDateRevision(DateRevisionDatabase()).findDateRevisionByIdRevision(idOld) ?? [];

    if (dateRevisions.isNotEmpty) {
      for (DateRevision dateRevision in dateRevisions) {
        dateRevision.idRevision = id;

        await UpdateDateRevision(DateRevisionDatabase(), dateRevision: dateRevision).writeDateRevision();
      }
    }
  }

  Future<void> postRevisionDisable() async {
    List<Revision>? lists = await GetRevision(RevisionDatabase()).findRevisionDisable() ?? [];

    if (lists.isNotEmpty) {
      for (Revision item in lists) {
        Response response = await Network(ConfigApi(), [Endpoint.revision, Endpoint.update]).post(RequestItem().convert(item));

        if (response.data != null) {
          item.sync = false;

          await Update(RevisionDatabase(), revision: item).write();
        }
      }
    }
  }
}
