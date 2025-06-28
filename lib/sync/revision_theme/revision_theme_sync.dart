import 'package:dio/dio.dart';
import 'package:planeje/revision/datasource/database/revision_database.dart';
import 'package:planeje/revision/entities/revision.dart';
import 'package:planeje/revision/utils/find_revision.dart';
import 'package:planeje/revision/utils/register_revision.dart';
import 'package:planeje/revision_theme/datasource/database/revision_theme_database.dart';
import 'package:planeje/revision_theme/entities/revision_theme.dart';
import 'package:planeje/revision_theme/utils/find_revision_theme.dart';
import 'package:planeje/revision_theme/utils/update_revision_theme.dart';
import 'package:planeje/sync/revision_theme/revision_theme_controller.dart';
import 'package:planeje/utils/networking/config_api.dart';
import 'package:planeje/utils/networking/endpoint.dart';
import 'package:planeje/utils/networking/endpoint/network.dart';
import 'package:planeje/utils/request_item.dart';

class RevisionThemeSync {
  Future<bool> getRevisionTheme() async {
    Response response = await Network(ConfigApi(), [Endpoint.revision, Endpoint.theme]).get();

    RevisionThemeController revisionThemeController = RevisionThemeController();

    if (response.data != null) {
      for (dynamic item in response.data) {
        RevisionTheme revisionTheme = RevisionTheme.fromMapToObject(item);

        revisionThemeController.revisionThemes.add(revisionTheme);
      }

      await revisionThemeController.deteleTable();

      await revisionThemeController.writeRevisionTheme();
    }
    return true;
  }

  Future<bool> postRevisionTheme() async {
    List<RevisionTheme> lists = await FindRevisionTheme(RevisionThemeDatabase()).findAllRevisionThemeSync() ?? [];

    if (lists.isNotEmpty) {
      for (RevisionTheme revisionTheme in lists) {
        int idOld = revisionTheme.id!;

        if (revisionTheme.insertApp!) revisionTheme.id = null;

        Response response = await Network(ConfigApi(), [Endpoint.revision, Endpoint.theme]).post(RevisionTheme.fromObjectToMap(revisionTheme));

        if (response.data != null) {
          revisionTheme.sync = true;

          await UpdateRevisionTheme(RevisionThemeDatabase()).write(revisionTheme);

          await updateIdRevisionTheme(response.data['id'], idOld);
        }
      }
    }
    return true;
  }

  Future<void> updateIdRevisionTheme(int id, int idOld) async {
    List<Revision> revisions = await GetRevision(RevisionDatabase()).findRevisioByIdRevisionTheme(idOld) ?? [];

    if (revisions.isNotEmpty) {
      for (Revision revision in revisions) {
        revision.idRevisionTheme = id;

        await Update(RevisionDatabase(), revision: revision).write();
      }
    }
  }

  Future<bool> postRevisionThemeDisable() async {
    List<RevisionTheme> lists = await FindRevisionTheme(RevisionThemeDatabase()).findRevisionThemeDisable() ?? [];

    if (lists.isNotEmpty) {
      for (RevisionTheme revisionTheme in lists) {
        Response response = await Network(ConfigApi(), [Endpoint.revision, Endpoint.theme, Endpoint.update]).post(RequestItem().convert(revisionTheme));

        if (response.data != null) {
          revisionTheme.sync = true;

          await UpdateRevisionTheme(RevisionThemeDatabase()).write(revisionTheme);
        }
      }
    }
    return true;
  }
}
