import 'package:flutter/material.dart';

import 'package:planeje/goal/entities/goal.dart';
import 'package:planeje/goal/pages/list_goal/component/dialog_delete_goal.dart';
import 'package:planeje/goal/pages/list_goal/component/dialog_finish_goal.dart';
import 'package:planeje/goal/pages/list_goal/controller/list_goal_controller.dart';
import 'package:planeje/goal/pages/register_goal/page/register_goal_page.dart';

import 'package:planeje/goal/usercases/goal_usercases.dart';
import 'package:planeje/utils/format_date.dart';
import 'package:planeje/utils/message_user.dart';
import 'package:planeje/widgets/app_bar_widget/add_app_bar_widget.dart';
import 'package:planeje/widgets/search.dart';

class ListGoal extends StatelessWidget {
  const ListGoal({super.key});

  String componentDate(String value) {
    DateTime date = FormatDate.newDate();
    int day = FormatDate.dateParse(value).difference(DateTime.utc(date.year, date.month, date.day)).inDays;

    if (day > 0) return 'Daqui a $day dias';
    if (day == 0) return 'Hoje';

    return 'Atrasada';
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color(0xffffffff),
        elevation: 0,
        toolbarHeight: 46,
        title: const Text(
          'Meta',
          style: TextStyle(fontSize: 18, color: Colors.black54, fontWeight: FontWeight.bold),
        ),
        actions: [
          Search(
            setValue: (value) {
              // setState(() => search = value ?? '');
            },
          ),
          AddAppBarWidget(
            onClick: () async {
              await Navigator.of(context).push(MaterialPageRoute<void>(builder: (context) => RegisterGoalPage()));
            },
          ),
        ],
      ),

      body: SingleChildScrollView(
        child: ValueListenableBuilder<bool>(
          valueListenable: GoalUsercases().reload,
          builder: (context, value, child) {
            return FutureBuilder(
              future: ListGoalController().getGoals(),
              builder: (BuildContext context, AsyncSnapshot<List<Goal>?> snapshot) {
                if (snapshot.hasData) {
                  if (snapshot.data!.isNotEmpty) {
                    final List<Goal> goals = snapshot.data!;

                    return ListView.separated(
                      itemCount: goals.length,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      separatorBuilder: (context, index) {
                        return const Divider(endIndent: 20, indent: 15, height: 1, color: Colors.grey);
                      },
                      itemBuilder: (context, index) {
                        return Dismissible(
                          key: UniqueKey(),
                          confirmDismiss: (DismissDirection direction) async {
                            if (direction == DismissDirection.startToEnd) {
                              try {
                                return await DialogDeleteGoal.build(context, snapshot.data![index]);
                              } catch (e) {
                                MessageUser.success('Erro ao abrir dialogo');
                              }
                            } else {
                              try {
                                await Navigator.of(context).push(MaterialPageRoute<void>(builder: (context) => RegisterGoalPage(goal: goals[index])));
                              } catch (e) {
                                MessageUser.error('Erro na rota revisão');
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
                            padding: const EdgeInsets.only(top: 5, bottom: 5, left: 15.0, right: 10.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      flex: 3,
                                      child: Text(
                                        goals[index].description.toString(),
                                        style: const TextStyle(fontSize: 17.0, fontWeight: FontWeight.w500, color: Color.fromARGB(130, 0, 0, 0)),
                                      ),
                                    ),
                                    Expanded(
                                      child: TextButton(
                                        style: TextButton.styleFrom(
                                          minimumSize: Size(0, 20),
                                          padding: EdgeInsets.symmetric(horizontal: 16),
                                          tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                          shape: RoundedRectangleBorder(
                                            side: BorderSide(
                                              color: !goals[index].concluded! ? const Color.fromARGB(123, 33, 149, 243) : Colors.grey,
                                              width: 0.4,
                                            ),
                                            borderRadius: BorderRadius.circular(05),
                                          ),
                                        ),
                                        onPressed: () async {
                                          await DialogFinishGoal.build(context, snapshot.data![index]);
                                        },
                                        child: Text(
                                          !goals[index].concluded! ? 'Finalizar' : 'Finalizado',
                                          style: TextStyle(
                                            fontWeight: FontWeight.w300,
                                            color: !goals[index].concluded! ? const Color.fromARGB(226, 33, 149, 243) : Colors.grey,
                                            fontSize: 13,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Visibility(
                                  visible: goals[index].complement != '',
                                  child: Text(
                                    goals[index].complement.toString(),
                                    style: const TextStyle(fontSize: 17.0, fontWeight: FontWeight.w500, color: Color.fromARGB(130, 0, 0, 0)),
                                  ),
                                ),
                                Text(
                                  'Prazo: ${FormatDate.formatDateCustumer(goals[index].date!)}',
                                  style: const TextStyle(fontSize: 15.0, fontWeight: FontWeight.w300, color: Color.fromARGB(130, 0, 0, 0)),
                                ),
                                Text(
                                  componentDate(goals[index].date!),
                                  style: const TextStyle(fontSize: 15.0, fontWeight: FontWeight.w300, color: Color.fromARGB(130, 0, 0, 0)),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  }
                  return const Center(
                    child: Text(
                      "Não há meta!!!",
                      style: TextStyle(fontSize: 18, color: Colors.black54, fontWeight: FontWeight.w300),
                    ),
                  );
                }
                return const Center(child: CircularProgressIndicator());
              },
            );
          },
        ),
      ),
    );
  }
}
