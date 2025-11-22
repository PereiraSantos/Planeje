import 'package:flutter/material.dart';
import 'package:planeje/annotation/utils/register_annotation.dart';
import 'package:planeje/utils/message_user.dart';
import 'package:planeje/widgets/persistent_footer_widget.dart';

import '../../../../widgets/text_button_widget.dart';
import '../component/drop_down_revision.dart';

// ignore: must_be_immutable
class RegisterAnnotation extends StatelessWidget {
  RegisterAnnotation({super.key, required this.registerAnnotation}) {
    description.text = registerAnnotation.annotation?.text ?? '';
    title.text = registerAnnotation.annotation?.title ?? '';
  }

  RegisterAnnotationFactory registerAnnotation;
  final formKey = GlobalKey<FormState>();
  final TextEditingController description = TextEditingController();
  final TextEditingController title = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xffffffff),
        elevation: 0,
        title: Text(
          registerAnnotation.message!.getTypeQuiz!.name,
          style: const TextStyle(fontSize: 18, color: Colors.black54, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(left: 20, right: 20, bottom: 80),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                DropDownButtonRevision(
                  onClick: (value) => registerAnnotation.annotation!.setIdRevision(value),
                  idRevision: registerAnnotation.annotation!.idRevision,
                ),
                Flexible(
                  child: TextFormField(
                    controller: title,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    maxLength: 200,
                    style: const TextStyle(fontSize: 18, color: Colors.black54),
                    decoration: InputDecoration(
                      labelText: 'Título',
                      hintStyle: TextStyle(color: Colors.grey.shade500, fontSize: 18, fontFamily: 'helvetica_neue_light'),
                    ),
                  ),
                ),
                Flexible(
                  child: TextFormField(
                    controller: description,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    maxLength: 1000,
                    style: const TextStyle(fontSize: 20, color: Colors.black54),
                    decoration: InputDecoration(
                      labelText: 'Descrição',
                      hintStyle: TextStyle(color: Colors.grey.shade500, fontSize: 20.0, fontFamily: 'helvetica_neue_light'),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Campo obrigatório';
                      }
                      return null;
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      persistentFooterButtons: [
        PersistentFooterWidget(
          children: [
            TextButtonWidget.cancel(() => Navigator.pop(context, false)),
            TextButtonWidget.save(() async {
              try {
                if (!formKey.currentState!.validate()) return;

                registerAnnotation.annotation!.setTitle(title.text);
                registerAnnotation.annotation!.setText(description.text);
                registerAnnotation.annotation!.setDateText(registerAnnotation.annotation!.dateText);

                await registerAnnotation.write();

                if (context.mounted) {
                  MessageUser.success(context, registerAnnotation.message!.message);
                  // ignore: use_build_context_synchronously
                  Navigator.pop(context, true);
                }
              } catch (e) {
                // ignore: use_build_context_synchronously
                MessageUser.error(context, 'Erro ao registrar anotação');
              }
            }),
          ],
        ),
      ],
    );
  }
}
