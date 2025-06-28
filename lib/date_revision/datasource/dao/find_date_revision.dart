import 'package:planeje/revision/entities/date_revision.dart';
import 'package:planeje/revision/entities/revision.dart';
import 'package:planeje/revision/entities/revision_time.dart';

import '../../../../database/app_database.dart';

class FindDateRevisionDao {
  Future<List<RevisionTime>> findDateRevisionById(AppDatabase database, int id) async {
    List<RevisionTime> listRevisionTime = [];
    List<Map> list =
        await database.database.rawQuery('select * from date_revision as dr inner join revision as r on r.id = dr.id_revision where id_date  = $id');

    for (var element in list) {
      listRevisionTime.add(
        RevisionTime(
          Revision(
            dateCreational: element['date_creational'],
            description: element['description'],
            id: element['id'],
            //   idLearn: element['id_learn'],
          ),
          DateRevision(
            dateRevision: element['date_revision'],
            idRevision: element['id_revision'],
            id: element['id_date'],
          ),
        ),
      );
    }
    return listRevisionTime;
  }
}
