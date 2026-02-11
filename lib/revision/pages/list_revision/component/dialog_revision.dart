import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:planeje/revision/datasource/database/date_revision_database.dart';
import 'package:planeje/revision/entities/date_revision.dart';

import 'package:planeje/revision/utils/register_date_revision.dart';
import 'package:planeje/utils/format_date.dart';
import 'package:planeje/utils/message_user.dart';
import 'package:planeje/widgets/text_form_field_widget.dart';

class DialogRevision {
  static Future<void> build(BuildContext context, int idRevision) async {
    final formKey = GlobalKey<FormState>();
    final TextEditingController dayNextRevision = TextEditingController();
    ValueNotifier<String> nextDateRevision = ValueNotifier<String>(FormatDate.formatDate(DateTime.now()));
    DateTime dateRevision = DateTime.now();

    if (!context.mounted) return;
    return await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          contentPadding: EdgeInsets.all(2),
          content: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormFieldWidget(
                  controller: dayNextRevision,
                  maxLine: 1,
                  hintText: 'Dias',
                  keyboardType: TextInputType.number,
                  textArea: false,
                  inputFormatter: [FilteringTextInputFormatter.digitsOnly],
                  onChange: (value) {
                    nextDateRevision.value = FormatDate.formatDate(dateRevision.add(Duration(days: value != '' ? int.parse(value!) : 0)));
                  },
                ),
                SizedBox(
                  width: double.maxFinite,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Text('Data: ${FormatDate.formatDate(dateRevision)}', style: TextStyle(color: Colors.black54)),
                  ),
                ),
                ValueListenableBuilder<String>(
                  valueListenable: nextDateRevision,
                  builder: (context, value, child) {
                    return SizedBox(
                      width: double.maxFinite,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 20),
                        child: Text('Próxima: $value', style: TextStyle(color: Colors.black54)),
                      ),
                    );
                  },
                ),
              ],
            ),
          ),

          actions: <Widget>[
            Padding(
              padding: const EdgeInsets.only(left: 10.0, right: 15.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context, false),
                    style: ButtonStyle(
                      foregroundColor: WidgetStateProperty.all(const Color.fromARGB(80, 0, 0, 0)),
                      padding: WidgetStateProperty.all(const EdgeInsets.symmetric(vertical: 6, horizontal: 30)),
                      textStyle: WidgetStateProperty.all(const TextStyle(fontSize: 18)),
                    ),
                    child: const Text("VOLTAR"),
                  ),
                  TextButton(
                    onPressed: () async {
                      if (!formKey.currentState!.validate()) return;

                      var result = await RegisterDateRevision(
                        DateRevisionDatabase(),
                        dateRevision: DateRevision(
                          dateRevision: FormatDate.formatDateStringNotification(dateRevision),
                          nextDateRevision: nextDateRevision.value,
                          idRevision: idRevision,
                          sync: false,
                          insertApp: true,
                        ),
                      ).writeDateRevision();

                      if (result != null && context.mounted) {
                        MessageUser.success('Registrado com sucesso');
                        // ignore: use_build_context_synchronously
                        Navigator.pop(context, true);
                      }
                    },
                    style: ButtonStyle(
                      foregroundColor: WidgetStateProperty.all(const Color.fromARGB(80, 0, 0, 0)),
                      padding: WidgetStateProperty.all(const EdgeInsets.symmetric(vertical: 6, horizontal: 30)),
                      textStyle: WidgetStateProperty.all(const TextStyle(fontSize: 18)),
                    ),
                    child: const Text("GRAVAR"),
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
