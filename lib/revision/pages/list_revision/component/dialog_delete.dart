import 'package:flutter/material.dart';
import 'package:planeje/annotation/datasource/database/annotation_database.dart';
import 'package:planeje/annotation/utils/delete_annotation.dart';
import 'package:planeje/revision/datasource/database/date_revision_database.dart';
import 'package:planeje/revision/datasource/database/revision_database.dart';
import 'package:planeje/revision/utils/delete_date_revision.dart';
import 'package:planeje/revision/utils/delete_revision.dart';
import 'package:planeje/utils/message_user.dart';

import '../../../entities/revision.dart';

class DialogDelete {
  static dynamic build(BuildContext context, Revision revision) async {
    if (!context.mounted) return;
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text("Deseja excluir? \n${revision.description!}", style: const TextStyle(color: Colors.black45, fontSize: 18)),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () async {
                      var result = await DeleteRevision(RevisionDatabase()).disableById(revision.id!);

                      if (result != null) {
                        await DeleteAnnotation(AnnotationDatabase()).disableByIdRevision(revision.id!);
                        await DeleteDateRevision(DateRevisionDatabase()).disableDateRevisionByIdRevision(revision.id!);
                      }

                      if (result != null && context.mounted) {
                        MessageUser.success(context, 'Removido com sucesso');
                        // ignore: use_build_context_synchronously
                        Navigator.pop(context, true);
                      }
                    },
                    style: ButtonStyle(
                      foregroundColor: WidgetStateProperty.all(const Color.fromARGB(80, 0, 0, 0)),
                      padding: WidgetStateProperty.all(const EdgeInsets.symmetric(vertical: 6, horizontal: 30)),
                      textStyle: WidgetStateProperty.all(const TextStyle(fontSize: 18)),
                    ),
                    child: const Text("SIM"),
                  ),
                  TextButton(
                    onPressed: () => Navigator.pop(context, false),
                    style: ButtonStyle(
                      foregroundColor: WidgetStateProperty.all(const Color.fromARGB(80, 0, 0, 0)),
                      padding: WidgetStateProperty.all(const EdgeInsets.symmetric(vertical: 6, horizontal: 30)),
                      textStyle: WidgetStateProperty.all(const TextStyle(fontSize: 18)),
                    ),
                    child: const Text("NÃO"),
                  ),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
