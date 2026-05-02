import 'package:flutter/material.dart';
import 'package:planeje/revision/datasource/database/date_revision_database.dart';
import 'package:planeje/revision/entities/date_revision.dart';
import 'package:planeje/revision/utils/find_date_revision.dart';

class CheckDateRevision extends StatelessWidget {
  const CheckDateRevision({super.key, required this.date});

  final String date;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 18,
      padding: EdgeInsets.only(left: 20, top: 2),
      child: FutureBuilder(
        future: GetDateRevision(DateRevisionDatabase()).getDateNextRevision(date),
        builder: (BuildContext context, AsyncSnapshot<List<DateRevision>?> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return SizedBox(width: 10, height: 10, child: CircularProgressIndicator(strokeWidth: 1));
          } else if (snapshot.connectionState == ConnectionState.done) {
            return (snapshot.data ?? []).isNotEmpty
                ? Text('Nessa data já existe revisão marcada.', style: TextStyle(color: const Color.fromARGB(255, 247, 114, 104)))
                : SizedBox();
          }

          return SizedBox();
        },
      ),
    );
  }
}
