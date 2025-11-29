import 'package:flutter/material.dart';
import 'package:planeje/revision/pages/list_revision/page/list_revision.dart';

import 'package:planeje/revision_theme/datasource/database/revision_theme_database.dart';
import 'package:planeje/revision_theme/entities/revision_theme.dart';
import 'package:planeje/revision_theme/entities/revision_theme_complement.dart';
import 'package:planeje/revision_theme/pages/regsister_revision_theme/page/register_revision_theme_page.dart';
import 'package:planeje/revision_theme/utils/find_revision_theme.dart';
import 'package:planeje/revision_theme/utils/register_revision_theme.dart';
import 'package:planeje/utils/format_date.dart';
import 'package:planeje/utils/message_user.dart';
import 'package:planeje/utils/transitions_builder.dart';
import 'package:planeje/utils/type_message.dart';

import 'package:planeje/widgets/app_bar_widget/add_app_bar_widget.dart';
import 'package:planeje/widgets/search.dart';

import '../component/dialog_delete.dart';

class ListRevisionTheme extends StatefulWidget {
  const ListRevisionTheme({super.key});

  @override
  State<ListRevisionTheme> createState() => _ListRevisionThemeState();
}

class _ListRevisionThemeState extends State<ListRevisionTheme> {
  String search = '';

  String componentDate(String dateRevision) {
    DateTime date = FormatDate.dateTimeParse(dateRevision);
    int day = FormatDate.newDate().difference(date).inDays;

    return day > 0 ? '- há $day dias' : '';
  }

  String _validDateIsNull(String? dateRevision) {
    if (dateRevision == null) return '';
    return '${FormatDate.formatDateString(dateRevision)} ${componentDate(dateRevision)}';
  }

  String _validTitleDescriptuionIsNull(String? title, String? description) {
    if (title == null || description == null) return 'Última revisão: Não há';
    return 'Última revisão: $title - $description ';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffffffff),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xffffffff),
        elevation: 0,
        toolbarHeight: 46,
        title: const Text(
          'Revisão',
          style: TextStyle(fontSize: 18, color: Colors.black54, fontWeight: FontWeight.bold),
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
                  RegisterRevisionThemePage(
                    revisionTheme: RegisterRevisioTheme(RevisionThemeDatabase(), revisionTheme: RevisionTheme(), message: StatusNotification()),
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
          future: FindRevisionTheme(RevisionThemeDatabase()).findRevisionThemeByDescription(search),
          builder: (BuildContext context, AsyncSnapshot<List<RevisionThemeComplement>> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.isNotEmpty) {
                return ListView.separated(
                  itemCount: snapshot.data!.length,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  separatorBuilder: (context, index) {
                    return const Divider(endIndent: 12, indent: 18, height: 1, color: Colors.grey);
                  },
                  itemBuilder: (context, index) {
                    return Dismissible(
                      key: UniqueKey(),
                      confirmDismiss: (DismissDirection direction) async {
                        if (direction == DismissDirection.startToEnd) {
                          try {
                            return await DialogDelete.build(context, snapshot.data![index]);
                          } catch (e) {
                            // ignore: use_build_context_synchronously
                            MessageUser.success(context, 'Erro ao abrir dialogo');
                          }
                        } else {
                          try {
                            // ignore: use_build_context_synchronously
                            var result = await Navigator.of(context).push(
                              TransitionsBuilder.createRoute(
                                RegisterRevisionThemePage(
                                  revisionTheme: UpdateRevisionTheme(
                                    RevisionThemeDatabase(),
                                    revisionTheme: snapshot.data![index],
                                    message: StatusNotification(TypeMessage.Atualizar),
                                  ),
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
                        padding: const EdgeInsets.only(left: 18.0, right: 10.0, bottom: 5, top: 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  flex: 10,
                                  child: Text(
                                    snapshot.data![index].description ?? '',
                                    style: const TextStyle(fontSize: 17.0, fontWeight: FontWeight.w500, color: Color.fromARGB(130, 0, 0, 0)),
                                  ),
                                ),
                                Expanded(
                                  child: GestureDetector(
                                    onTap: () async {
                                      await Navigator.of(context).push(TransitionsBuilder.createRoute(ListRevision(revisionTheme: snapshot.data![index])));
                                    },
                                    child: const Icon(Icons.menu_book_rounded, size: 20, color: Colors.black45),
                                  ),
                                ),
                              ],
                            ),
                            Text(
                              _validTitleDescriptuionIsNull(snapshot.data![index].title, snapshot.data![index].revisionDescription),
                              style: const TextStyle(fontSize: 15.0, fontWeight: FontWeight.w300),
                              overflow: TextOverflow.ellipsis,
                              maxLines: 2,
                            ),
                            Visibility(
                              visible: snapshot.data![index].dateRevision != null,
                              child: Text(
                                _validDateIsNull(snapshot.data![index].dateRevision),
                                style: const TextStyle(fontSize: 15.0, fontWeight: FontWeight.w300),
                              ),
                            ),
                          ],
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
