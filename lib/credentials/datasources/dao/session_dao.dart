import 'package:floor/floor.dart';
import 'package:planeje/credentials/entities/session.dart';

@dao
abstract class SessionDao {
  @Insert()
  Future<int?> register(Session session);

  @Query('delete from session')
  Future<void> delete();

  @Query('select * from session')
  Future<Session?> findSession();
}
