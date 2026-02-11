import 'package:planeje/database/app_database.dart';
import 'package:planeje/goal/entities/goal.dart';

class ListGoalController {
  Future<List<Goal>> getGoals() async {
    AppDatabase database = await getInstance();
    return await database.goalDAO.findAllGolas();
  }
}
