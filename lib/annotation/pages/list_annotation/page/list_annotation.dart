import 'package:flutter/material.dart';
import 'package:planeje/annotation/datasource/database/annotation_database.dart';
import 'package:planeje/annotation/pages/register_annotation/pages/register_annotation.dart';
import 'package:planeje/annotation/utils/delete_annotation.dart';
import 'package:planeje/annotation/utils/filter_notifier.dart';
import 'package:planeje/annotation/utils/find_annotation.dart';
import 'package:planeje/annotation/utils/register_annotation.dart';
import 'package:planeje/utils/message_user.dart';
import 'package:planeje/utils/type_message.dart';
import 'package:planeje/widgets/tab_bar_widget/tab_bar_notifier.dart';
import '../../../../utils/transitions_builder.dart';

import '../../../../widgets/dialog_delete.dart';
import '../../../entities/annotation_revision.dart';
import '../component/text_list.dart';

// ignore: must_be_immutable
class ListAnnotation extends StatelessWidget {
  ListAnnotation(this.annotationNotifier, {super.key});
  Notifier annotationNotifier;
  FilterNotifier filterNotifier = FilterNotifier();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          FutureBuilder(
            future: GetAnnotation(AnnotationDatabase()).getAnnotationWidthRevision(annotationNotifier.search ?? ''),
            builder: (BuildContext context, AsyncSnapshot<List<AnnotationRevision>?> snapshot) {
              if (snapshot.hasData) {
                if (snapshot.data!.isNotEmpty) {
                  filterNotifier.setAnnotation(snapshot.data!);

                  return ListenableBuilder(
                    listenable: filterNotifier,
                    builder: (BuildContext context, Widget? child) {
                      return ListView.separated(
                        itemCount: snapshot.data!.length,
                        shrinkWrap: true,
                        separatorBuilder: (context, index) {
                          return const Divider(endIndent: 10, indent: 10);
                        },
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return Dismissible(
                            key: UniqueKey(),
                            confirmDismiss: (DismissDirection direction) async {
                              if (direction == DismissDirection.startToEnd) {
                                try {
                                  return await DialogDelete().build(context, snapshot.data![index].text!, () async {
                                    return await DeleteAnnotation(AnnotationDatabase()).disableById(snapshot.data![index].id!);
                                  });
                                } catch (e) {
                                  // ignore: use_build_context_synchronously
                                  MessageUser.error(context, 'Erro ao abrir dialogo');
                                }
                              }
                              return null;
                            },
                            background: const Align(
                              alignment: Alignment(-0.9, 0),
                              child: Icon(Icons.delete, color: Colors.red, size: 30),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(left: 10, right: 5.0),
                              child: GestureDetector(
                                onTap: () async {
                                  try {
                                    var result = await Navigator.of(context).push(
                                      TransitionsBuilder.createRoute(
                                        RegisterAnnotation(
                                          registerAnnotation: UpdateAnnotation(
                                            AnnotationDatabase(),
                                            annotation: snapshot.data![index],
                                            message: StatusNotification(TypeMessage.Atualizar),
                                          ),
                                        ),
                                      ),
                                    );
                                    if (result) annotationNotifier.update();
                                  } catch (e) {
                                    // ignore: use_build_context_synchronously
                                    MessageUser.error(context, 'Erro na rota anotação');
                                  }
                                },
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Visibility(
                                      visible: snapshot.data![index].idRevision != null,
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [const TextList("Tema:", flex: 1), TextList("${snapshot.data![index].description}", flex: 6, fontSize: 17)],
                                      ),
                                    ),
                                    Visibility(
                                      visible: snapshot.data![index].title != "",
                                      child: Row(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        mainAxisAlignment: MainAxisAlignment.start,
                                        children: [
                                          TextList("${snapshot.data![index].title}", color: Colors.black54, fontWeight: FontWeight.w500, fontSize: 17),
                                        ],
                                      ),
                                    ),
                                    Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      mainAxisSize: MainAxisSize.min,
                                      children: [TextList(snapshot.data![index].text ?? "")],
                                    ),
                                    const Padding(padding: EdgeInsets.all(3)),
                                  ],
                                ),
                              ),
                            ),
                          );
                        },
                      );
                    },
                  );
                } else {
                  return const Center(
                    child: Text(
                      "Não há anotação!!!",
                      style: TextStyle(fontSize: 22, color: Colors.black54, fontWeight: FontWeight.w300),
                    ),
                  );
                }
              } else {
                return const Center(child: CircularProgressIndicator());
              }
            },
          ),
        ],
      ),
    );
  }
}
