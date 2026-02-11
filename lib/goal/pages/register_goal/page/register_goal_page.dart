import 'package:flutter/material.dart';
import 'package:planeje/goal/entities/goal.dart';

import 'package:planeje/goal/pages/register_goal/controller/goal_controller.dart';
import 'package:planeje/goal/pages/register_goal/style/style_custom.dart';

import 'package:planeje/goal/widgets/elevated_buttom_custom.dart';
import 'package:planeje/utils/message_user.dart';
import 'package:planeje/widgets/persistent_footer_widget.dart';
import 'package:planeje/widgets/text_button_widget.dart';
import 'package:planeje/widgets/text_form_field_widget.dart';

class RegisterGoalPage extends StatelessWidget {
  RegisterGoalPage({super.key, this.goal}) {
    _description.text = goal?.description ?? '';
    _complement.text = goal?.complement ?? '';
    _goalController.id = goal?.id;

    if (goal?.date != null) _goalController.date = goal!.date!;
  }

  final Goal? goal;
  final GlobalKey<FormState> _form = GlobalKey<FormState>();
  final TextEditingController _description = TextEditingController();
  final TextEditingController _complement = TextEditingController();
  final GoalController _goalController = GoalController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xffffffff),
        elevation: 0,
        title: Text(
          goal != null ? 'Atualizar' : 'Adicionar',
          style: const TextStyle(fontSize: 18, color: Colors.black54, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Form(
          key: _form,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormFieldWidget(controller: _description, maxLine: 1, hintText: 'Descrição', keyboardType: TextInputType.text, textArea: false),
              TextFormFieldWidget(
                controller: _complement,
                maxLine: 5,
                hintText: 'Complemento',
                keyboardType: TextInputType.multiline,
                textArea: true,
                valid: false,
              ),

              Padding(
                padding: const EdgeInsets.only(top: 20, left: 20),
                child: Text('Prazo final', style: StyleCustom().style()),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: ValueListenableBuilder<String>(
                  valueListenable: _goalController.date,
                  builder: (context, value, child) {
                    return ElevatedButtomCustom(
                      onPressed: () => _goalController.openCalendar(context),
                      title: value,
                      color: const Color.fromARGB(171, 107, 185, 248),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      persistentFooterButtons: [
        PersistentFooterWidget(
          children: [
            TextButtonWidget.cancel(() => Navigator.pop(context, false)),
            TextButtonWidget.save(() async {
              try {
                if (!_form.currentState!.validate()) return null;
                await _goalController.saveGoal(_form, _description.text, _complement.text);
                // ignore: use_build_context_synchronously

                if (context.mounted) {
                  FocusScope.of(context).requestFocus(FocusNode());
                  MessageUser.success(goal != null ? 'Atualizado com sucesso' : 'Registrado com sucesso');

                  Navigator.pop(context);
                }
              } catch (e) {
                if (context.mounted) {
                  FocusScope.of(context).requestFocus(FocusNode());
                  MessageUser.error('Erro ao registrar!!!, $e');
                }
              }
            }),
          ],
        ),
      ],
    );
  }
}
