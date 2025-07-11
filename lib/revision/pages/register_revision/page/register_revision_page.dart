import 'package:flutter/material.dart';
import 'package:planeje/annotation/datasource/database/annotation_database.dart';
import 'package:planeje/annotation/entities/annotation.dart';
import 'package:planeje/annotation/utils/delete_annotation.dart';
import 'package:planeje/annotation/utils/register_annotation.dart';
import 'package:planeje/revision/utils/register_revision.dart';
import 'package:planeje/utils/type_message.dart';
import 'package:planeje/widgets/persistent_footer_widget.dart';
import 'package:planeje/widgets/dialog_annotation.dart';
import '../../../../utils/message_user.dart';
import '../../../../widgets/text_button_widget.dart';
import '../../../../widgets/text_form_field_widget.dart';

// ignore: must_be_immutable
class RegisterRevisionPage extends StatefulWidget {
  RegisterRevisionPage({super.key, required this.revision, required this.id, this.annotations});

  RevisionFactory revision;
  List<Annotation>? annotations;
  int id;

  @override
  State<RegisterRevisionPage> createState() => _RegisterRevisionPageState();
}

class _RegisterRevisionPageState extends State<RegisterRevisionPage> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController title = TextEditingController();
  final TextEditingController description = TextEditingController();
  InsertAnnotation registerAnnotation = InsertAnnotation(AnnotationDatabase(), annotation: Annotation());
  String nextDate = '';

  @override
  void initState() {
    super.initState();
    description.text = widget.revision.revision?.description ?? '';
    title.text = widget.revision.revision?.title ?? '';
    if (widget.revision.revision?.id == null) widget.annotations = [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xffffffff),
        elevation: 0,
        title: Text(
          widget.revision.message!.getTypeQuiz!.name,
          style: const TextStyle(fontSize: 18, color: Colors.black54, fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(top: 0.0),
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                TextFormFieldWidget(
                  controller: title,
                  maxLine: 1,
                  hintText: 'Título',
                  keyboardType: TextInputType.text,
                  textArea: false,
                ),
                TextFormFieldWidget(
                  controller: description,
                  maxLine: 5,
                  hintText: 'Descrição',
                  keyboardType: TextInputType.multiline,
                  textArea: true,
                ),
                TextButton(
                  onPressed: () async {
                    await DialogAnnotation().build(context, <AnnotationRevision>(String title, String description) async {
                      Annotation annotation = Annotation(title: title, text: description);

                      if (widget.annotations!.isEmpty) annotation.setId(-1);
                      if (widget.annotations!.isNotEmpty) {
                        var id = (widget.annotations!.last.id ?? -1);
                        if (id > 0) id = 0;
                        annotation.setId(id - 1);
                      }

                      widget.annotations!.add(annotation);
                      setState(() {});
                    });
                  },
                  child: const Text('Adicionar anotação', style: TextStyle(color: Colors.grey, fontSize: 16)),
                ),
                ListView.separated(
                  itemCount: widget.annotations!.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  padding: const EdgeInsets.only(left: 20, right: 5),
                  separatorBuilder: (context, index) {
                    return const Divider(endIndent: 5, indent: 5);
                  },
                  itemBuilder: (context, index) {
                    return Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          flex: 18,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Text('Título: ${widget.annotations![index].title}', style: const TextStyle(color: Colors.black54)),
                              Text('Descrição: ${widget.annotations![index].text}', style: const TextStyle(color: Colors.black54)),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: SizedBox(
                            height: 35,
                            child: IconButton(
                                onPressed: () async {
                                  await DialogAnnotation().build(
                                      titleArg: widget.annotations![index].title,
                                      descriptionArg: widget.annotations![index].text ?? '',
                                      context, <AnnotationRevision>(String title, String description) async {
                                    widget.annotations![index].title = title;
                                    widget.annotations![index].text = description;

                                    setState(() {});
                                  });
                                },
                                icon: const Icon(Icons.edit, size: 18, color: Colors.blue)),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: SizedBox(
                            height: 35,
                            child: IconButton(
                                onPressed: () async {
                                  if (widget.annotations![index].id != null) {
                                    await DeleteAnnotation(AnnotationDatabase()).disableById(widget.annotations![index].id!);
                                  }

                                  setState(() {
                                    FocusScope.of(context).requestFocus(FocusNode());
                                    widget.annotations!.removeAt(index);
                                    MessageUser.message(context, 'Deletado com sucesso!!!');
                                  });
                                },
                                icon: const Icon(Icons.delete, size: 18, color: Colors.red)),
                          ),
                        )
                      ],
                    );
                  },
                ),
                const Padding(padding: EdgeInsets.all(50))
              ],
            ),
          ),
        ),
      ),
      persistentFooterButtons: [
        PersistentFooterWidget(
          children: [
            TextButtonWidget.cancel(() => Navigator.pop(context, false)),
            TextButtonWidget.save(
              () async {
                try {
                  if (!formKey.currentState!.validate()) return;

                  widget.revision.revision?.setId(widget.revision.revision?.id);

                  widget.revision.revision?.setTitle(title.text);
                  widget.revision.revision?.setDescription(description.text);
                  widget.revision.revision?.setDateCreational(widget.revision.revision?.dateCreational);
                  widget.revision.revision?.setSync();
                  widget.revision.revision?.setIdTevisionTheme(widget.id);
                  if (widget.revision.revision?.id == null) widget.revision.revision?.setInsertApp(true);

                  var idRevision = await widget.revision.write();

                  if (idRevision == null) return;

                  for (Annotation annotation in widget.annotations!) {
                    if (annotation.id != null && annotation.id! < 0) {
                      registerAnnotation.annotation?.setId(null);
                      annotation.id = null;
                      registerAnnotation.annotation?.setInsertApp(true);
                    }

                    registerAnnotation.annotation?.setTitle(annotation.title ?? '');
                    registerAnnotation.annotation?.setText(annotation.text ?? '');

                    registerAnnotation.annotation?.setIdRevision(widget.revision.revision?.id ?? idRevision);
                    registerAnnotation.annotation?.setDateText(null);
                    registerAnnotation.annotation?.setSync();

                    annotation.id == null
                        ? await registerAnnotation.write()
                        : await UpdateAnnotation(AnnotationDatabase(),
                                annotation: Annotation(
                                  id: annotation.id,
                                  idRevision: annotation.idRevision,
                                  title: annotation.title,
                                  text: annotation.text,
                                  dateText: annotation.dateText,
                                )..setSync(),
                                message: StatusNotification())
                            .write();
                  }

                  if (idRevision != null && context.mounted) {
                    FocusScope.of(context).requestFocus(FocusNode());
                    await MessageUser.message(context, widget.revision.message!.message);
                    // ignore: use_build_context_synchronously
                    Navigator.pop(context, true);
                  }
                } catch (e) {
                  if (context.mounted) {
                    FocusScope.of(context).requestFocus(FocusNode());
                    await MessageUser.message(context, 'Erro ao registrar!!!, $e');
                  }
                }
              },
            ),
          ],
        ),
      ],
    );
  }
}
