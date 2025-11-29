import 'package:floor/floor.dart';
import 'package:planeje/credentials/entities/last_session.dart';

@dao
abstract class LastSessionDao {
  @Insert()
  Future<void> register(LastSession lastSession);

  @Update()
  Future<void> update(LastSession lastSession);

  @Query('select * from last_session')
  Future<LastSession?> findLastSession();
}
