import 'package:planeje/database/app_database.dart';
import 'package:planeje/revision/entities/date_revision.dart';
import 'package:planeje/revision_theme/entities/revision_theme_complement.dart';
import 'package:planeje/utils/format_date.dart';

class RevisionThemeInfoDao {
  Future<List<RevisionThemeComplement>> findRevisionThemeById(AppDatabase database, String text) async {
    try {
      List<RevisionThemeComplement> revisionThemeComplements = [];

      String sql = 'SELECT rt.* FROM revision_theme as rt ';

      sql += text != "" ? 'where rt.description LIKE \'%$text%\' and rt.disable = 0' : 'where rt.disable = 0 ';

      List<Map<String, dynamic>> list = await database.database.rawQuery(sql);

      for (var element in list) {
        RevisionThemeComplement revisionThemeComplement = RevisionThemeComplement(
          null,
          null,
          null,
          null,
          element['id'],
          element['description'],
          element['sync'] == 1,
        );
        int idRevisionTheme = element['id'];
        String sqlRevision = 'SELECT * FROM revision where id_revision_theme = $idRevisionTheme';

        List<Map> listRevision = await database.database.rawQuery(sqlRevision);

        List<DateRevision> listRevisionTime = [];

        for (var item in listRevision) {
          int idRevision = item['id'];
          String sqlDate = 'select * from date_revision where id_revision = $idRevision order by id_date desc limit 1';
          List<Map> listDate = await database.database.rawQuery(sqlDate);

          listRevisionTime.add(
            DateRevision(
              dateRevision: listDate[0]['date_revision'],
              idRevision: listDate[0]['id_revision'],
              id: listDate[0]['id_date'],
              nextDateRevision: listDate[0]['next_date_revision'],
            ),
          );
        }

        if (listRevisionTime.isNotEmpty) {
          listRevisionTime.sort((a, b) => FormatDate.dateParse(a.nextDateRevision!).compareTo(FormatDate.dateParse(b.nextDateRevision!)));

          revisionThemeComplement.dateRevision = listRevisionTime[0].dateRevision;
          revisionThemeComplement.nextDateRevision = listRevisionTime[0].nextDateRevision;

          var result = listRevision.where((e) => e['id'] == listRevisionTime[0].idRevision).toList();

          if (result.isNotEmpty) {
            revisionThemeComplement.revisionDescription = result[0]['description'];
            revisionThemeComplement.title = result[0]['title'];
          }
        }

        revisionThemeComplements.add(revisionThemeComplement);
      }

      return revisionThemeComplements;
    } catch (e) {
      rethrow;
    }
  }
}
