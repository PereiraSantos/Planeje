import 'package:flutter/material.dart';
import 'package:planeje/revision_theme/utils/register_revision_theme.dart';
import 'package:planeje/utils/message_user.dart';
import 'package:planeje/widgets/persistent_footer_widget.dart';
import 'package:planeje/widgets/text_button_widget.dart';
import 'package:planeje/widgets/text_form_field_widget.dart';

class RegisterRevisionThemePage extends StatelessWidget {
  RegisterRevisionThemePage({super.key, required this.revisionTheme}) {
    description.text = revisionTheme.revisionTheme?.description ?? '';
  }

  final RevisionThemeFactory revisionTheme;
  final formKey = GlobalKey<FormState>();
  final TextEditingController description = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xffffffff),
        elevation: 0,
        title: Text(
          revisionTheme.message!.getTypeQuiz!.name,
          style: const TextStyle(fontSize: 18, color: Colors.black54, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 0.0),
          child: Form(
            key: formKey,
            child: Column(
              children: [TextFormFieldWidget(controller: description, maxLine: 5, hintText: 'Tema', keyboardType: TextInputType.multiline, textArea: true)],
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

                revisionTheme.revisionTheme?.setId(revisionTheme.revisionTheme?.id);

                revisionTheme.revisionTheme?.setDescription(description.text);

                revisionTheme.revisionTheme?.setSync();

                if (revisionTheme.revisionTheme?.id == null) revisionTheme.revisionTheme?.setInsertApp(true);

                var idRevision = await revisionTheme.write();

                if (idRevision == null) return;

                if (idRevision != null && context.mounted) {
                  FocusScope.of(context).requestFocus(FocusNode());
                  MessageUser.success(context, revisionTheme.message!.message);
                  // ignore: use_build_context_synchronously
                  Navigator.pop(context, true);
                }
              } catch (e) {
                if (context.mounted) {
                  FocusScope.of(context).requestFocus(FocusNode());
                  MessageUser.error(context, 'Erro ao registrar!!!, $e');
                }
              }
            }),
          ],
        ),
      ],
    );
  }
}
