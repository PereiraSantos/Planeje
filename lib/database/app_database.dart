import 'dart:async';

import 'package:floor/floor.dart';
import 'package:planeje/annotation/datasource/dao/annotation_dao.dart';
import 'package:planeje/login/datasource/dao/user_dao.dart';
import 'package:planeje/login/entities/user.dart';
import 'package:planeje/quiz_revision/datasource/dao/question_dao.dart';
import 'package:planeje/quiz_revision/datasource/dao/quiz_dao.dart';
import 'package:planeje/revision/datasource/dao/date_revision_dao.dart';
import 'package:planeje/revision/datasource/dao/revision_dao.dart';
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

final migration1to2 = Migration(1, 2, (database) async {
  await database.execute(
      'CREATE TABLE IF NOT EXISTS `user` (`id` INTEGER NOT NULL, `login` TEXT NOT NULL, `password` TEXT NOT NULL, `keep_logged` INTEGER NOT NULL, PRIMARY KEY (`id`))');
});

@Database(version: 2, entities: [
  Revision,
  DateRevision,
  Annotation,
  Quiz,
  Question,
  Settings,
  User,
])
abstract class AppDatabase extends FloorDatabase {
  RevisionDao get revisionDao;
  DateRevisionDao get dateRevisionDao;
  AnnotationDao get annotationDao;
  QuizDao get quizDao;
  QuestionDao get questionDao;
  SettingDao get settingDao;
  UserDao get userDao;
}

Future<AppDatabase> migrationDatabase() async {
  return await $FloorAppDatabase.databaseBuilder('app_database.db').addMigrations([migration1to2]).build();
}

Future<AppDatabase> getInstance() async {
  return await $FloorAppDatabase.databaseBuilder('app_database.db').build();
}
