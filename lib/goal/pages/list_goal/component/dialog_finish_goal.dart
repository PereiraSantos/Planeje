import 'package:flutter/material.dart';
import 'package:planeje/goal/entities/goal.dart';
import 'package:planeje/goal/pages/register_goal/controller/goal_controller.dart';
import 'package:planeje/utils/message_user.dart';

class DialogFinishGoal {
  static dynamic build(BuildContext context, Goal goal) async {
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          content: Text("Deseja finalizar? \n${goal.description}", style: const TextStyle(color: Colors.black45, fontSize: 18)),
          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () async {
                      await GoalController().update(goal.id!);

                      if (context.mounted) {
                        MessageUser.success('Atualizado com sucesso');
                        // ignore: use_build_context_synchronously
                        Navigator.pop(context);
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
