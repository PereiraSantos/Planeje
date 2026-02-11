import 'package:floor/floor.dart';
import 'package:planeje/goal/entities/goal.dart';

@dao
abstract class GoalDAO {
  @Query('SELECT * FROM goal')
  Future<List<Goal>> findAllGolas();

  @insert
  Future<int> insertGoal(Goal goal);

  @update
  Future<int> updateGoal(Goal goal);

  @Query('delete from goal where id = :id')
  Future<void> deletGoal(int id);
}
