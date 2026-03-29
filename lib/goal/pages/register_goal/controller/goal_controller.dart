import 'package:flutter/material.dart';
import 'package:planeje/goal/entities/goal.dart';

import 'package:planeje/goal/usercases/goal_usercases.dart';
import 'package:planeje/utils/format_date.dart';

class GoalController {
  int? _idGoal;

  final ValueNotifier<String> date = ValueNotifier<String>(FormatDate.formatDataBase(DateTime.now()));

  set date(String value) => date.value = value;

  set id(int? id) => _idGoal = id;

  Future<void> openCalendar(BuildContext context) async {
    final DateTime? result = await showDatePicker(
      context: context,
      initialDate: FormatDate.dateParse(date.value),
      firstDate: DateTime.now(),
      lastDate: DateTime(2099),
      helpText: 'Selecione uma data',
      cancelText: 'Sair',
      confirmText: 'Selecionar',
      locale: const Locale('pt', 'BR'),
    );

    if (result != null) date.value = FormatDate.formatDataBase(result);
  }

  Future<void> saveGoal(GlobalKey<FormState> form, String value, String description) async {
    _idGoal != null
        ? await GoalUsercases().updateGoal(Goal(id: _idGoal, description: value, complement: description, date: date.value))
        : await GoalUsercases().insertGoal(Goal(description: value, complement: description, date: date.value));
  }

  Future<void> delete(int id) async => await GoalUsercases().delete(id);

  Future<void> update(int id) async => await GoalUsercases().updateConcluded(id);
}
