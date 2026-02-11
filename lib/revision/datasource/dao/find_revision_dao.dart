import 'package:planeje/revision/entities/date_revision.dart';
import 'package:planeje/revision/entities/revision.dart';
import 'package:planeje/revision/entities/revision_time.dart';
import 'package:planeje/utils/format_date.dart';
import '../../../../database/app_database.dart';

class FindRevisionDao {
  Future<List<RevisionTime>> findRevision(AppDatabase database, String text, int id, bool isBefore, {int? limit}) async {
    List<RevisionTime> listRevisionTime = [];
    String filter = text != ''
        ? 'where r.id_revision_theme = $id and r.disable = 0 and (r.title like \'%$text%\' or r.description like \'%$text%\')'
        : 'where r.id_revision_theme = $id and r.disable = 0';

    String sqlBase = 'SELECT r.* FROM revision as r $filter';

    List<Map> list = await database.database.rawQuery(sqlBase);

    for (var element in list) {
      int id = element['id'];
      String sql = 'select * from date_revision where id_revision = $id order by id_date desc limit 1';
      List<Map> listDate = await database.database.rawQuery(sql);

      listRevisionTime.add(
        RevisionTime(
          Revision(
            dateCreational: element['date_creational'],
            description: element['description'],
            id: element['id'],
            title: element['title'],
            idRevisionTheme: element['id_revision_theme'],
          ),
          DateRevision(
            dateRevision: listDate[0]['date_revision'],
            idRevision: listDate[0]['id_revision'],
            id: listDate[0]['id_date'],
            nextDateRevision: listDate[0]['next_date_revision'],
          ),
          listDate[0]['next_date_revision'],
        ),
      );
    }

    listRevisionTime.sort((a, b) => FormatDate.dateParse(a.date!).compareTo(FormatDate.dateParse(b.date!)));

    return listRevisionTime;
  }
}
