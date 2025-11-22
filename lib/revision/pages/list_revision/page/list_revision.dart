import 'package:flutter/material.dart';
import 'package:planeje/annotation/datasource/database/annotation_database.dart';
import 'package:planeje/annotation/entities/annotation.dart';
import 'package:planeje/annotation/utils/find_annotation.dart';
import 'package:planeje/revision/datasource/database/date_revision_database.dart';
import 'package:planeje/revision/datasource/database/revision_database.dart';
import 'package:planeje/revision/entities/revision.dart';
import 'package:planeje/revision/entities/revision_time.dart';
import 'package:planeje/revision/pages/list_revision/component/dialog_delete.dart';
import 'package:planeje/revision/pages/register_revision/page/register_revision_page.dart';
import 'package:planeje/revision/utils/find_revision.dart';
import 'package:planeje/revision/utils/register_date_revision.dart';
import 'package:planeje/revision/utils/register_revision.dart';
import 'package:planeje/revision_theme/entities/revision_theme.dart';
import 'package:planeje/utils/message_user.dart';
import 'package:planeje/utils/transitions_builder.dart';
import 'package:planeje/utils/type_message.dart';
import 'package:planeje/widgets/app_bar_widget/add_app_bar_widget.dart';
import 'package:planeje/widgets/expansion_tile_widgets.dart';
import 'package:planeje/widgets/search.dart';

class ListRevision extends StatefulWidget {
  const ListRevision({super.key, required this.revisionTheme});

  final RevisionTheme revisionTheme;

  @override
  State<ListRevision> createState() => _ListRevisionState();
}

class _ListRevisionState extends State<ListRevision> {
  String search = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xffffffff),
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back_rounded, color: Colors.black54, size: 22),
        ),
        elevation: 0,
        toolbarHeight: 46,
        title: Text(
          'Revisões ${widget.revisionTheme.description}',
          style: const TextStyle(fontSize: 18, color: Colors.black54, fontWeight: FontWeight.bold),
        ),
        actions: [
          Search(
            setValue: (value) {
              setState(() => search = value ?? '');
            },
          ),
          AddAppBarWidget(
            onClick: () async {
              var result = await Navigator.of(context).push(
                TransitionsBuilder.createRoute(
                  RegisterRevisionPage(
                    revision: Register(RevisionDatabase(), revision: Revision(), message: StatusNotification()),
                    id: widget.revisionTheme.id!,
                  ),
                ),
              );

              if (result) setState(() {});
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: FutureBuilder(
          future: GetRevision(RevisionDatabase()).findRevisionByDescription(search, widget.revisionTheme.id!, false),
          builder: (BuildContext context, AsyncSnapshot<List<RevisionTime>> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.isNotEmpty) {
                return ListView.separated(
                  itemCount: snapshot.data!.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  separatorBuilder: (context, index) {
                    return const Divider(endIndent: 22, indent: 22, height: 1, color: Colors.grey);
                  },
                  itemBuilder: (context, index) {
                    return Dismissible(
                      key: UniqueKey(),
                      confirmDismiss: (DismissDirection direction) async {
                        if (direction == DismissDirection.startToEnd) {
                          try {
                            return await DialogDelete.build(context, snapshot.data![index].revision);
                          } catch (e) {
                            // ignore: use_build_context_synchronously
                            MessageUser.success(context, 'Erro ao abrir dialogo');
                          }
                        } else {
                          try {
                            List<Annotation>? list = await GetAnnotation(AnnotationDatabase()).getAnnotationWidthIdRevision(snapshot.data![index].revision.id!);

                            // ignore: use_build_context_synchronously
                            var result = await Navigator.of(context).push(
                              TransitionsBuilder.createRoute(
                                RegisterRevisionPage(
                                  revision: Update(
                                    RevisionDatabase(),
                                    revision: snapshot.data![index].revision,
                                    message: StatusNotification(TypeMessage.Atualizar),
                                    registerDate: UpdateDateRevision(DateRevisionDatabase(), dateRevision: snapshot.data![index].dateRevision),
                                  ),
                                  id: widget.revisionTheme.id!,
                                  annotations: list,
                                ),
                              ),
                            );
                            if (result) setState(() {});
                          } catch (e) {
                            // ignore: use_build_context_synchronously
                            MessageUser.error(context, 'Erro na rota revisão');
                          }
                        }
                        return null;
                      },
                      background: const Align(
                        alignment: Alignment(-0.9, 0),
                        child: Icon(Icons.delete, color: Colors.red, size: 30),
                      ),
                      secondaryBackground: const Align(
                        alignment: Alignment(-0.9, 0),
                        child: Icon(Icons.edit, color: Colors.blue, size: 30),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(left: 5.0, right: 5.0),
                        child: ExpansionTileWidgets(
                          revision: snapshot.data![index].revision,
                          dateRevision: snapshot.data![index].dateRevision,
                          onClick: () => setState(() {}),
                        ),
                      ),
                    );
                  },
                );
              } else {
                return const Center(
                  child: Text(
                    "Não há revisão!!!",
                    style: TextStyle(fontSize: 18, color: Colors.black54, fontWeight: FontWeight.w300),
                  ),
                );
              }
            } else {
              return const Center(child: CircularProgressIndicator());
            }
          },
        ),
      ),
    );
  }
}
