import 'package:flutter/material.dart';
import 'package:planeje/quiz_revision/datasource/database/question_database.dart';
import 'package:planeje/quiz_revision/datasource/database/revision_quiz_database.dart';
import 'package:planeje/quiz_revision/entities/quiz.dart';
import 'package:planeje/quiz_revision/utils/revision_quiz/delete_revision_quiz.dart';
import 'package:planeje/quiz_revision/utils/register_question/register_question.dart';
import 'package:planeje/quiz_revision/utils/register_question/remove_question.dart';
import 'package:planeje/quiz_revision/utils/register_question/table_question.dart';
import 'package:planeje/quiz_revision/utils/register_quiz/find_list_quiz.dart';
import 'package:planeje/quiz_revision/utils/register_quiz/remove_quiz.dart';
import 'package:planeje/utils/message_user.dart';
import 'package:planeje/utils/type_message.dart';
import 'package:planeje/widgets/app_bar_widget/add_app_bar_widget.dart';
import 'package:planeje/widgets/search.dart';
import '../../../../utils/transitions_builder.dart';

import '../../../datasource/database/quiz_database.dart';
import '../../../entities/question.dart';
import '../../../utils/register_quiz/register_quiz.dart';
import '../../register_quiz/page/register_quiz_page.dart';
import '../component/dialog_delete.dart';
import '../component/list_question.dart';

// ignore: must_be_immutable
class ListQuiz extends StatefulWidget {
  const ListQuiz({super.key});

  @override
  State<ListQuiz> createState() => _ListQuizState();
}

class _ListQuizState extends State<ListQuiz> {
  String search = '';

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
          'Quiz',
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
                  RegisterQuizPage(
                    registerQuiz: SaveQuiz(QuizDatabase(), quiz: Quiz(), message: StatusNotification()),
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
          future: GetQuiz(QuizDatabase()).getAllQuiz(search),
          builder: (BuildContext context, AsyncSnapshot<List<Quiz>?> snapshot) {
            if (snapshot.hasData) {
              if (snapshot.data!.isNotEmpty) {
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
                            var result = await DialogDelete.build(context, snapshot.data![index]);

                            if (result && context.mounted) {
                              final TableQuestionNotifier tableQuestionNotifier = TableQuestionNotifier();
                              await tableQuestionNotifier.deleteQuestionByIdQuiz(snapshot.data![index].id!);

                              await RemoveQuestion(QuestionDatabase()).delete(tableQuestionNotifier.questions);

                              await DeleteQuiz(QuizDatabase()).disableById(snapshot.data![index].id!);
                              await DeleteRevisionQuiz(RevisionQuizDatabase()).disableRevisionQuizByIdQuiz(snapshot.data![index].id!);
                              tableQuestionNotifier.clearList();

                              if (!context.mounted) return;
                              MessageUser.success(context, 'Removido com sucesso');
                              setState(() {});
                            }
                          } catch (e) {
                            // ignore: use_build_context_synchronously
                            MessageUser.error(context, 'Erro ao abrir dialogo');
                          }
                        } else {
                          try {
                            var result = await Navigator.of(context).push(
                              TransitionsBuilder.createRoute(
                                RegisterQuizPage(
                                  registerQuiz: UpdateQuiz(QuizDatabase(), quiz: (snapshot.data![index]), message: StatusNotification(TypeMessage.Atualizar)),
                                ),
                              ),
                            );
                            if (result) setState(() {});
                          } catch (e) {
                            // ignore: use_build_context_synchronously
                            MessageUser.error(context, 'Erro na rota quiz revisão');
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
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Visibility(
                              visible: snapshot.data![index].topic != '',
                              child: Padding(
                                padding: const EdgeInsets.only(left: 10, top: 10, right: 10),
                                child: Text(
                                  snapshot.data![index].topic ?? '',
                                  style: const TextStyle(fontSize: 16, color: Colors.black54, fontWeight: FontWeight.w500),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 10, right: 10, bottom: 05),
                              child: Text(
                                "${snapshot.data![index].description}?",
                                overflow: TextOverflow.ellipsis,
                                style: const TextStyle(fontSize: 15, color: Colors.black54, fontWeight: FontWeight.w400),
                              ),
                            ),
                            FutureBuilder(
                              future: GetQuestion(QuestionDatabase()).getQuestionByIdQuiz(snapshot.data![index].id!),
                              builder: (BuildContext context, AsyncSnapshot<List<Question>?> snapshot) {
                                if (snapshot.hasData) {
                                  if (snapshot.data!.isNotEmpty) {
                                    return ListQuestion(listQuestion: snapshot.data ?? []);
                                  }

                                  return const SizedBox();
                                }
                                return const Center(child: CircularProgressIndicator());
                              },
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
                    "Não há quiz!!!",
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
