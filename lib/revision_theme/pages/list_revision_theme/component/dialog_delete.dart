import 'package:flutter/material.dart';
import 'package:planeje/revision/datasource/database/revision_database.dart';
import 'package:planeje/revision/entities/revision.dart';
import 'package:planeje/revision/utils/find_revision.dart';
import 'package:planeje/revision_theme/datasource/database/revision_theme_database.dart';
import 'package:planeje/revision_theme/utils/delete_revision_theme.dart';
import 'package:planeje/utils/message_user.dart';

import '../../../entities/revision_theme.dart';

class DialogDelete {
  static dynamic build(BuildContext context, RevisionTheme revisionTheme) async {
    if (!context.mounted) return;
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text("Deseja excluir? \n${revisionTheme.description!}", style: const TextStyle(color: Colors.black45, fontSize: 18)),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () async {
                      List<Revision> list = await GetRevision(RevisionDatabase()).findRevisioByIdRevisionTheme(revisionTheme.id!) ?? [];

                      if (list.isNotEmpty) {
                        // ignore: use_build_context_synchronously
                        MessageUser.success(context, 'Não é possível remover tem revisão vinculada!!!!');
                        // ignore: use_build_context_synchronously
                        Navigator.pop(context, false);
                        return;
                      }

                      var result = await DeleteRevisionTheme(RevisionThemeDatabase()).disableById(revisionTheme.id!);

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
