import 'package:flutter/material.dart';
import 'package:planeje/utils/message_user.dart';

class DialogDelete {
  dynamic build<T>(BuildContext context, String text, Future<T> Function() onPressed) async {
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text("Deseja excluir? \n$text", style: const TextStyle(color: Colors.black45, fontSize: 18)),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () async {
                      try {
                        var result = await onPressed();

                        if (result != null && context.mounted) {
                          MessageUser.success(context, 'Removido com sucesso');
                          // ignore: use_build_context_synchronously
                          Navigator.pop(context, true);
                        }
                      } catch (e) {
                        // ignore: use_build_context_synchronously
                        MessageUser.error(context, 'Erro ao deletar');
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
                    onPressed: () => Navigator.of(context).pop(false),
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
