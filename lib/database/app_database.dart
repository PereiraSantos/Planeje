import 'dart:async';

import 'package:floor/floor.dart';
import 'package:planeje/annotation/datasource/dao/annotation_dao.dart';
import 'package:planeje/credentials/datasources/dao/last_session_dao.dart';
import 'package:planeje/credentials/datasources/dao/session_dao.dart';
import 'package:planeje/credentials/datasources/dao/user_dao.dart';
import 'package:planeje/credentials/entities/last_session.dart';
import 'package:planeje/credentials/entities/session.dart';
import 'package:planeje/credentials/entities/user.dart';
import 'package:planeje/quiz_revision/datasource/dao/question_dao.dart';
import 'package:planeje/quiz_revision/datasource/dao/quiz_dao.dart';
import 'package:planeje/quiz_revision/datasource/dao/revision_quiz_dao.dart';
import 'package:planeje/quiz_revision/entities/revision_quiz.dart';
import 'package:planeje/revision/datasource/dao/date_revision_dao.dart';
import 'package:planeje/revision/datasource/dao/revision_dao.dart';
import 'package:planeje/revision_theme/datasource/dao/revision_theme_dao.dart';
import 'package:planeje/revision_theme/entities/revision_theme.dart';
import 'package:planeje/settings/datasource/dao/setting_dao.dart';

// ignore: depend_on_referenced_packages
import 'package:sqflite/sqflite.dart' as sqflite;

import '../annotation/entities/annotation.dart';
import '../quiz_revision/entities/question.dart';
import '../quiz_revision/entities/quiz.dart';

import '../revision/entities/date_revision.dart';
import '../revision/entities/revision.dart';
import '../settings/entities/settings.dart';

part 'app_database.g.dart';

/*
final migration1to2 = Migration(1, 2, (database) async {
  await database.execute(
      'CREATE TABLE IF NOT EXISTS `user` (`id` INTEGER NOT NULL, `login` TEXT NOT NULL, `password` TEXT NOT NULL, `keep_logged` INTEGER NOT NULL, PRIMARY KEY (`id`))');
});

final migration2to3 = Migration(2, 3, (database) async {
  await database.execute(
      'CREATE TABLE IF NOT EXISTS `revision_quiz` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `date_revision` TEXT, `answer` INTEGER, `id_quiz` INTEGER)');
  await database.execute(
      'CREATE TABLE IF NOT EXISTS `revision_quiz` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `id_external` INTEGER, `date_revision` TEXT, `answer` INTEGER, `id_quiz` INTEGER, `sync` INTEGER)');
  await database.execute('ALTER annotation ADD COLUMN sync INTEGER');
  await database.execute('ALTER question ADD COLUMN sync INTEGER');
  await database.execute('ALTER revision_quiz ADD COLUMN sync INTEGER');
  await database.execute('ALTER revision ADD COLUMN sync INTEGER');
  await database.execute('ALTER date_revision ADD COLUMN sync INTEGER');
  await database.execute('ALTER quiz ADD COLUMN sync INTEGER');
  await database.execute(
      'CREATE TABLE IF NOT EXISTS `revision_theme` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `id_external` INTEGER, `description` TEXT, `sync` INTEGER)');
  await database.execute('ALTER revision ADD COLUMN id_revision_theme INTEGER');
});*/

@Database(version: 1, entities: [
  Revision,
  DateRevision,
  Annotation,
  Quiz,
  Question,
  Settings,
  User,
  RevisionQuiz,
  RevisionTheme,
  Session,
  LastSession,
])
abstract class AppDatabase extends FloorDatabase {
  RevisionDao get revisionDao;
  DateRevisionDao get dateRevisionDao;
  AnnotationDao get annotationDao;
  QuizDao get quizDao;
  QuestionDao get questionDao;
  SettingDao get settingDao;
  UserDao get userDao;
  RevisionQuizDao get revisionQuizDao;
  RevisionThemeDao get revisionThemeDao;
  SessionDao get sessionDao;
  LastSessionDao get lastSessionDao;
}
/*
Future<AppDatabase> migrationDatabase() async {
  return await $FloorAppDatabase.databaseBuilder('app_database.db').addMigrations([migration1to2, migration2to3]).build();
}*/

Future<AppDatabase> getInstance() async {
  return await $FloorAppDatabase.databaseBuilder('app_database.db').build();
}
