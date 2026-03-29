import 'package:flutter/material.dart';
import 'package:planeje/database/app_database.dart';
import 'package:planeje/goal/entities/goal.dart';

class GoalUsercases {
  static final GoalUsercases _singleton = GoalUsercases._internal();

  factory GoalUsercases() => _singleton;

  GoalUsercases._internal();

  final ValueNotifier<bool> reload = ValueNotifier<bool>(false);

  Future<void> delete(int id) async {
    reload.value = false;
    AppDatabase database = await getInstance();
    await database.goalDAO.deleteGoal(id);
    reload.value = true;
  }

  Future<void> insertGoal(Goal goal) async {
    reload.value = false;
    AppDatabase database = await getInstance();
    await database.goalDAO.insertGoal(goal);
    reload.value = true;
  }

  Future<void> updateGoal(Goal goal) async {
    reload.value = false;
    AppDatabase database = await getInstance();
    await database.goalDAO.updateGoal(goal);
    reload.value = true;
  }

  Future<void> updateConcluded(int id) async {
    reload.value = false;
    AppDatabase database = await getInstance();
    await database.goalDAO.updateConcluded(id, true);
    reload.value = true;
  }
}
