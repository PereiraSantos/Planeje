// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

abstract class $AppDatabaseBuilderContract {
  /// Adds migrations to the builder.
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations);

  /// Adds a database [Callback] to the builder.
  $AppDatabaseBuilderContract addCallback(Callback callback);

  /// Creates the database and initializes it.
  Future<AppDatabase> build();
}

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static $AppDatabaseBuilderContract inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder implements $AppDatabaseBuilderContract {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  @override
  $AppDatabaseBuilderContract addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  @override
  $AppDatabaseBuilderContract addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  @override
  Future<AppDatabase> build() async {
    final path = name != null
        ? await sqfliteDatabaseFactory.getDatabasePath(name!)
        : ':memory:';
    final database = _$AppDatabase();
    database.database = await database.open(
      path,
      _migrations,
      _callback,
    );
    return database;
  }
}

class _$AppDatabase extends AppDatabase {
  _$AppDatabase([StreamController<String>? listener]) {
    changeListener = listener ?? StreamController<String>.broadcast();
  }

  RevisionDao? _revisionDaoInstance;

  DateRevisionDao? _dateRevisionDaoInstance;

  AnnotationDao? _annotationDaoInstance;

  QuizDao? _quizDaoInstance;

  QuestionDao? _questionDaoInstance;

  SettingDao? _settingDaoInstance;

  UserDao? _userDaoInstance;

  RevisionQuizDao? _revisionQuizDaoInstance;

  RevisionThemeDao? _revisionThemeDaoInstance;

  SessionDao? _sessionDaoInstance;

  LastSessionDao? _lastSessionDaoInstance;

  Future<sqflite.Database> open(
    String path,
    List<Migration> migrations, [
    Callback? callback,
  ]) async {
    final databaseOptions = sqflite.OpenDatabaseOptions(
      version: 1,
      onConfigure: (database) async {
        await database.execute('PRAGMA foreign_keys = ON');
        await callback?.onConfigure?.call(database);
      },
      onOpen: (database) async {
        await callback?.onOpen?.call(database);
      },
      onUpgrade: (database, startVersion, endVersion) async {
        await MigrationAdapter.runMigrations(
            database, startVersion, endVersion, migrations);

        await callback?.onUpgrade?.call(database, startVersion, endVersion);
      },
      onCreate: (database, version) async {
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `revision` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `title` TEXT, `description` TEXT, `date_creational` TEXT, `id_revision_theme` INTEGER, `sync` INTEGER, `disable` INTEGER, `insert_app` INTEGER)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `date_revision` (`id_date` INTEGER PRIMARY KEY AUTOINCREMENT, `date_revision` TEXT, `id_revision` INTEGER, `sync` INTEGER, `disable` INTEGER, `insert_app` INTEGER)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `annotation` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `title` TEXT, `text` TEXT, `date_text` TEXT, `id_revision` INTEGER, `sync` INTEGER, `disable` INTEGER, `insert_app` INTEGER)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `quiz` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `topic` TEXT, `description` TEXT, `sync` INTEGER, `disable` INTEGER, `insert_app` INTEGER)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `question` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `id_quiz` INTEGER, `description` TEXT, `answer` INTEGER, `sync` INTEGER, `disable` INTEGER, `insert_app` INTEGER)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `setting` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `keystone` TEXT, `value` TEXT)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `user` (`email` TEXT NOT NULL, `password` TEXT NOT NULL, PRIMARY KEY (`email`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `revision_quiz` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `date_revision` TEXT, `answer` INTEGER, `id_quiz` INTEGER, `sync` INTEGER, `disable` INTEGER, `insert_app` INTEGER)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `revision_theme` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `description` TEXT, `sync` INTEGER, `disable` INTEGER, `insert_app` INTEGER)');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `session` (`id` INTEGER NOT NULL, `email_user` TEXT NOT NULL, `token` TEXT NOT NULL, PRIMARY KEY (`id`))');
        await database.execute(
            'CREATE TABLE IF NOT EXISTS `last_session` (`id` INTEGER NOT NULL, `email` TEXT NOT NULL, PRIMARY KEY (`id`))');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  RevisionDao get revisionDao {
    return _revisionDaoInstance ??= _$RevisionDao(database, changeListener);
  }

  @override
  DateRevisionDao get dateRevisionDao {
    return _dateRevisionDaoInstance ??=
        _$DateRevisionDao(database, changeListener);
  }

  @override
  AnnotationDao get annotationDao {
    return _annotationDaoInstance ??= _$AnnotationDao(database, changeListener);
  }

  @override
  QuizDao get quizDao {
    return _quizDaoInstance ??= _$QuizDao(database, changeListener);
  }

  @override
  QuestionDao get questionDao {
    return _questionDaoInstance ??= _$QuestionDao(database, changeListener);
  }

  @override
  SettingDao get settingDao {
    return _settingDaoInstance ??= _$SettingDao(database, changeListener);
  }

  @override
  UserDao get userDao {
    return _userDaoInstance ??= _$UserDao(database, changeListener);
  }

  @override
  RevisionQuizDao get revisionQuizDao {
    return _revisionQuizDaoInstance ??=
        _$RevisionQuizDao(database, changeListener);
  }

  @override
  RevisionThemeDao get revisionThemeDao {
    return _revisionThemeDaoInstance ??=
        _$RevisionThemeDao(database, changeListener);
  }

  @override
  SessionDao get sessionDao {
    return _sessionDaoInstance ??= _$SessionDao(database, changeListener);
  }

  @override
  LastSessionDao get lastSessionDao {
    return _lastSessionDaoInstance ??=
        _$LastSessionDao(database, changeListener);
  }
}

class _$RevisionDao extends RevisionDao {
  _$RevisionDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _revisionInsertionAdapter = InsertionAdapter(
            database,
            'revision',
            (Revision item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'description': item.description,
                  'date_creational': item.dateCreational,
                  'id_revision_theme': item.idRevisionTheme,
                  'sync': item.sync == null ? null : (item.sync! ? 1 : 0),
                  'disable':
                      item.disable == null ? null : (item.disable! ? 1 : 0),
                  'insert_app':
                      item.insertApp == null ? null : (item.insertApp! ? 1 : 0)
                }),
        _revisionUpdateAdapter = UpdateAdapter(
            database,
            'revision',
            ['id'],
            (Revision item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'description': item.description,
                  'date_creational': item.dateCreational,
                  'id_revision_theme': item.idRevisionTheme,
                  'sync': item.sync == null ? null : (item.sync! ? 1 : 0),
                  'disable':
                      item.disable == null ? null : (item.disable! ? 1 : 0),
                  'insert_app':
                      item.insertApp == null ? null : (item.insertApp! ? 1 : 0)
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Revision> _revisionInsertionAdapter;

  final UpdateAdapter<Revision> _revisionUpdateAdapter;

  @override
  Future<List<Revision>> findAllRevisions() async {
    return _queryAdapter.queryList('SELECT * FROM revision',
        mapper: (Map<String, Object?> row) => Revision(
            id: row['id'] as int?,
            title: row['title'] as String?,
            description: row['description'] as String?,
            dateCreational: row['date_creational'] as String?,
            idRevisionTheme: row['id_revision_theme'] as int?,
            sync: row['sync'] == null ? null : (row['sync'] as int) != 0,
            disable:
                row['disable'] == null ? null : (row['disable'] as int) != 0,
            insertApp: row['insert_app'] == null
                ? null
                : (row['insert_app'] as int) != 0));
  }

  @override
  Future<List<Revision>?> findAllRevisionsSync() async {
    return _queryAdapter.queryList(
        'SELECT * FROM revision where sync = 0 and disable = 0',
        mapper: (Map<String, Object?> row) => Revision(
            id: row['id'] as int?,
            title: row['title'] as String?,
            description: row['description'] as String?,
            dateCreational: row['date_creational'] as String?,
            idRevisionTheme: row['id_revision_theme'] as int?,
            sync: row['sync'] == null ? null : (row['sync'] as int) != 0,
            disable:
                row['disable'] == null ? null : (row['disable'] as int) != 0,
            insertApp: row['insert_app'] == null
                ? null
                : (row['insert_app'] as int) != 0));
  }

  @override
  Future<Revision?> findRevisionById(int id) async {
    return _queryAdapter.query('SELECT * FROM revision WHERE id = ?1',
        mapper: (Map<String, Object?> row) => Revision(
            id: row['id'] as int?,
            title: row['title'] as String?,
            description: row['description'] as String?,
            dateCreational: row['date_creational'] as String?,
            idRevisionTheme: row['id_revision_theme'] as int?,
            sync: row['sync'] == null ? null : (row['sync'] as int) != 0,
            disable:
                row['disable'] == null ? null : (row['disable'] as int) != 0,
            insertApp: row['insert_app'] == null
                ? null
                : (row['insert_app'] as int) != 0),
        arguments: [id]);
  }

  @override
  Future<Revision?> disableRevisionById(int id) async {
    return _queryAdapter.query('update revision set disable = 1 WHERE id = ?1',
        mapper: (Map<String, Object?> row) => Revision(
            id: row['id'] as int?,
            title: row['title'] as String?,
            description: row['description'] as String?,
            dateCreational: row['date_creational'] as String?,
            idRevisionTheme: row['id_revision_theme'] as int?,
            sync: row['sync'] == null ? null : (row['sync'] as int) != 0,
            disable:
                row['disable'] == null ? null : (row['disable'] as int) != 0,
            insertApp: row['insert_app'] == null
                ? null
                : (row['insert_app'] as int) != 0),
        arguments: [id]);
  }

  @override
  Future<List<Revision>> findRevisionByDescription(String text) async {
    return _queryAdapter.queryList('SELECT * FROM revision WHERE text LIKE ?1',
        mapper: (Map<String, Object?> row) => Revision(
            id: row['id'] as int?,
            title: row['title'] as String?,
            description: row['description'] as String?,
            dateCreational: row['date_creational'] as String?,
            idRevisionTheme: row['id_revision_theme'] as int?,
            sync: row['sync'] == null ? null : (row['sync'] as int) != 0,
            disable:
                row['disable'] == null ? null : (row['disable'] as int) != 0,
            insertApp: row['insert_app'] == null
                ? null
                : (row['insert_app'] as int) != 0),
        arguments: [text]);
  }

  @override
  Future<List<Revision>?> findRevisioByIdRevisionTheme(
      int idRevisionTheme) async {
    return _queryAdapter.queryList(
        'SELECT * FROM revision where id_revision_theme = ?1 and disable = 0',
        mapper: (Map<String, Object?> row) => Revision(
            id: row['id'] as int?,
            title: row['title'] as String?,
            description: row['description'] as String?,
            dateCreational: row['date_creational'] as String?,
            idRevisionTheme: row['id_revision_theme'] as int?,
            sync: row['sync'] == null ? null : (row['sync'] as int) != 0,
            disable:
                row['disable'] == null ? null : (row['disable'] as int) != 0,
            insertApp: row['insert_app'] == null
                ? null
                : (row['insert_app'] as int) != 0),
        arguments: [idRevisionTheme]);
  }

  @override
  Future<List<Revision>?> findRevisionDisable() async {
    return _queryAdapter.queryList('SELECT * FROM revision where  disable = 1',
        mapper: (Map<String, Object?> row) => Revision(
            id: row['id'] as int?,
            title: row['title'] as String?,
            description: row['description'] as String?,
            dateCreational: row['date_creational'] as String?,
            idRevisionTheme: row['id_revision_theme'] as int?,
            sync: row['sync'] == null ? null : (row['sync'] as int) != 0,
            disable:
                row['disable'] == null ? null : (row['disable'] as int) != 0,
            insertApp: row['insert_app'] == null
                ? null
                : (row['insert_app'] as int) != 0));
  }

  @override
  Future<void> deleteTable() async {
    await _queryAdapter.queryNoReturn('delete from revision');
  }

  @override
  Future<int> insertRevision(Revision revision) {
    return _revisionInsertionAdapter.insertAndReturnId(
        revision, OnConflictStrategy.abort);
  }

  @override
  Future<List<int>> insertRevisionList(List<Revision> revision) {
    return _revisionInsertionAdapter.insertListAndReturnIds(
        revision, OnConflictStrategy.abort);
  }

  @override
  Future<int> updateRevision(Revision revision) {
    return _revisionUpdateAdapter.updateAndReturnChangedRows(
        revision, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateRevisionList(List<Revision> revision) async {
    await _revisionUpdateAdapter.updateList(revision, OnConflictStrategy.abort);
  }
}

class _$DateRevisionDao extends DateRevisionDao {
  _$DateRevisionDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _dateRevisionInsertionAdapter = InsertionAdapter(
            database,
            'date_revision',
            (DateRevision item) => <String, Object?>{
                  'id_date': item.id,
                  'date_revision': item.dateRevision,
                  'id_revision': item.idRevision,
                  'sync': item.sync == null ? null : (item.sync! ? 1 : 0),
                  'disable':
                      item.disable == null ? null : (item.disable! ? 1 : 0),
                  'insert_app':
                      item.insertApp == null ? null : (item.insertApp! ? 1 : 0)
                }),
        _dateRevisionUpdateAdapter = UpdateAdapter(
            database,
            'date_revision',
            ['id_date'],
            (DateRevision item) => <String, Object?>{
                  'id_date': item.id,
                  'date_revision': item.dateRevision,
                  'id_revision': item.idRevision,
                  'sync': item.sync == null ? null : (item.sync! ? 1 : 0),
                  'disable':
                      item.disable == null ? null : (item.disable! ? 1 : 0),
                  'insert_app':
                      item.insertApp == null ? null : (item.insertApp! ? 1 : 0)
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<DateRevision> _dateRevisionInsertionAdapter;

  final UpdateAdapter<DateRevision> _dateRevisionUpdateAdapter;

  @override
  Future<List<DateRevision>> findAllRevisions() async {
    return _queryAdapter.queryList('SELECT * FROM date_revision',
        mapper: (Map<String, Object?> row) => DateRevision(
            id: row['id_date'] as int?,
            dateRevision: row['date_revision'] as String?,
            idRevision: row['id_revision'] as int?,
            sync: row['sync'] == null ? null : (row['sync'] as int) != 0,
            disable:
                row['disable'] == null ? null : (row['disable'] as int) != 0,
            insertApp: row['insert_app'] == null
                ? null
                : (row['insert_app'] as int) != 0));
  }

  @override
  Future<List<DateRevision>?> findAllDateRevisionSync() async {
    return _queryAdapter.queryList(
        'SELECT * FROM date_revision where sync = 0 and disable = 0',
        mapper: (Map<String, Object?> row) => DateRevision(
            id: row['id_date'] as int?,
            dateRevision: row['date_revision'] as String?,
            idRevision: row['id_revision'] as int?,
            sync: row['sync'] == null ? null : (row['sync'] as int) != 0,
            disable:
                row['disable'] == null ? null : (row['disable'] as int) != 0,
            insertApp: row['insert_app'] == null
                ? null
                : (row['insert_app'] as int) != 0));
  }

  @override
  Future<List<DateRevision>?> findDateRevisionDisable() async {
    return _queryAdapter.queryList(
        'SELECT * FROM date_revision where disable = 1',
        mapper: (Map<String, Object?> row) => DateRevision(
            id: row['id_date'] as int?,
            dateRevision: row['date_revision'] as String?,
            idRevision: row['id_revision'] as int?,
            sync: row['sync'] == null ? null : (row['sync'] as int) != 0,
            disable:
                row['disable'] == null ? null : (row['disable'] as int) != 0,
            insertApp: row['insert_app'] == null
                ? null
                : (row['insert_app'] as int) != 0));
  }

  @override
  Future<List<DateRevision>?> findDateRevisionByIdRevision(
      int idRevision) async {
    return _queryAdapter.queryList(
        'SELECT * FROM date_revision where id_revision = ?1 and disable = 0',
        mapper: (Map<String, Object?> row) => DateRevision(
            id: row['id_date'] as int?,
            dateRevision: row['date_revision'] as String?,
            idRevision: row['id_revision'] as int?,
            sync: row['sync'] == null ? null : (row['sync'] as int) != 0,
            disable:
                row['disable'] == null ? null : (row['disable'] as int) != 0,
            insertApp: row['insert_app'] == null
                ? null
                : (row['insert_app'] as int) != 0),
        arguments: [idRevision]);
  }

  @override
  Future<DateRevision?> disableDateRevisionById(int id) async {
    return _queryAdapter.query(
        'update date_revision set disable = 1 WHERE id = ?1',
        mapper: (Map<String, Object?> row) => DateRevision(
            id: row['id_date'] as int?,
            dateRevision: row['date_revision'] as String?,
            idRevision: row['id_revision'] as int?,
            sync: row['sync'] == null ? null : (row['sync'] as int) != 0,
            disable:
                row['disable'] == null ? null : (row['disable'] as int) != 0,
            insertApp: row['insert_app'] == null
                ? null
                : (row['insert_app'] as int) != 0),
        arguments: [id]);
  }

  @override
  Future<DateRevision?> disableDateRevisionByIdRevision(int idRevision) async {
    return _queryAdapter.query(
        'update date_revision set disable = 1 WHERE id_revision = ?1',
        mapper: (Map<String, Object?> row) => DateRevision(
            id: row['id_date'] as int?,
            dateRevision: row['date_revision'] as String?,
            idRevision: row['id_revision'] as int?,
            sync: row['sync'] == null ? null : (row['sync'] as int) != 0,
            disable:
                row['disable'] == null ? null : (row['disable'] as int) != 0,
            insertApp: row['insert_app'] == null
                ? null
                : (row['insert_app'] as int) != 0),
        arguments: [idRevision]);
  }

  @override
  Future<void> updateHourInitRevision(
    String hourInit,
    int id,
  ) async {
    await _queryAdapter.queryNoReturn(
        'update date_revision set hour_init = ?1 where id_date = ?2',
        arguments: [hourInit, id]);
  }

  @override
  Future<void> updateHourEndRevision(
    String hourEnd,
    String dateRevision,
    String nextDateRevision,
    int id,
  ) async {
    await _queryAdapter.queryNoReturn(
        'update date_revision set date_revision = ?2, next_date_revision = ?3, hour_end = ?1 where id_date = ?4',
        arguments: [hourEnd, dateRevision, nextDateRevision, id]);
  }

  @override
  Future<void> updateStatus(
    bool status,
    int id,
  ) async {
    await _queryAdapter.queryNoReturn(
        'update date_revision set status = ?1 where id_date = ?2',
        arguments: [status ? 1 : 0, id]);
  }

  @override
  Future<DateRevision?> findDateRevisionById(int id) async {
    return _queryAdapter.query(
        'select * from date_revision  where id_date = ?1',
        mapper: (Map<String, Object?> row) => DateRevision(
            id: row['id_date'] as int?,
            dateRevision: row['date_revision'] as String?,
            idRevision: row['id_revision'] as int?,
            sync: row['sync'] == null ? null : (row['sync'] as int) != 0,
            disable:
                row['disable'] == null ? null : (row['disable'] as int) != 0,
            insertApp: row['insert_app'] == null
                ? null
                : (row['insert_app'] as int) != 0),
        arguments: [id]);
  }

  @override
  Future<void> deleteTable() async {
    await _queryAdapter.queryNoReturn('delete from date_revision');
  }

  @override
  Future<int> insertDateRevision(DateRevision dateRevision) {
    return _dateRevisionInsertionAdapter.insertAndReturnId(
        dateRevision, OnConflictStrategy.abort);
  }

  @override
  Future<List<int>> insertDateRevisionList(List<DateRevision> dateRevision) {
    return _dateRevisionInsertionAdapter.insertListAndReturnIds(
        dateRevision, OnConflictStrategy.abort);
  }

  @override
  Future<int> updateDateRevision(DateRevision dateRevision) {
    return _dateRevisionUpdateAdapter.updateAndReturnChangedRows(
        dateRevision, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateDateRevisionList(List<DateRevision> dateRevision) async {
    await _dateRevisionUpdateAdapter.updateList(
        dateRevision, OnConflictStrategy.abort);
  }
}

class _$AnnotationDao extends AnnotationDao {
  _$AnnotationDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _annotationInsertionAdapter = InsertionAdapter(
            database,
            'annotation',
            (Annotation item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'text': item.text,
                  'date_text': item.dateText,
                  'id_revision': item.idRevision,
                  'sync': item.sync == null ? null : (item.sync! ? 1 : 0),
                  'disable':
                      item.disable == null ? null : (item.disable! ? 1 : 0),
                  'insert_app':
                      item.insertApp == null ? null : (item.insertApp! ? 1 : 0)
                }),
        _annotationUpdateAdapter = UpdateAdapter(
            database,
            'annotation',
            ['id'],
            (Annotation item) => <String, Object?>{
                  'id': item.id,
                  'title': item.title,
                  'text': item.text,
                  'date_text': item.dateText,
                  'id_revision': item.idRevision,
                  'sync': item.sync == null ? null : (item.sync! ? 1 : 0),
                  'disable':
                      item.disable == null ? null : (item.disable! ? 1 : 0),
                  'insert_app':
                      item.insertApp == null ? null : (item.insertApp! ? 1 : 0)
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Annotation> _annotationInsertionAdapter;

  final UpdateAdapter<Annotation> _annotationUpdateAdapter;

  @override
  Future<void> disable(int id) async {
    await _queryAdapter.queryNoReturn(
        'update annotation set disable = 1 where id = ?1',
        arguments: [id]);
  }

  @override
  Future<void> disableByIdRevision(int idRevision) async {
    await _queryAdapter.queryNoReturn(
        'update annotation set disable = 1 where id_revision = ?1',
        arguments: [idRevision]);
  }

  @override
  Future<List<Annotation>?> getAnnotationWidthIdRevision(int idRevision) async {
    return _queryAdapter.queryList(
        'select * from annotation where id_revision = ?1 and disable = 0',
        mapper: (Map<String, Object?> row) => Annotation(
            id: row['id'] as int?,
            title: row['title'] as String?,
            text: row['text'] as String?,
            dateText: row['date_text'] as String?,
            idRevision: row['id_revision'] as int?,
            sync: row['sync'] == null ? null : (row['sync'] as int) != 0,
            disable:
                row['disable'] == null ? null : (row['disable'] as int) != 0,
            insertApp: row['insert_app'] == null
                ? null
                : (row['insert_app'] as int) != 0),
        arguments: [idRevision]);
  }

  @override
  Future<List<Annotation>?> getAnnotationAll() async {
    return _queryAdapter.queryList(
        'select * from annotation where and disable = 0',
        mapper: (Map<String, Object?> row) => Annotation(
            id: row['id'] as int?,
            title: row['title'] as String?,
            text: row['text'] as String?,
            dateText: row['date_text'] as String?,
            idRevision: row['id_revision'] as int?,
            sync: row['sync'] == null ? null : (row['sync'] as int) != 0,
            disable:
                row['disable'] == null ? null : (row['disable'] as int) != 0,
            insertApp: row['insert_app'] == null
                ? null
                : (row['insert_app'] as int) != 0));
  }

  @override
  Future<List<Annotation>?> findAnnotationSync() async {
    return _queryAdapter.queryList(
        'select * from annotation where sync = 0 and disable = 0',
        mapper: (Map<String, Object?> row) => Annotation(
            id: row['id'] as int?,
            title: row['title'] as String?,
            text: row['text'] as String?,
            dateText: row['date_text'] as String?,
            idRevision: row['id_revision'] as int?,
            sync: row['sync'] == null ? null : (row['sync'] as int) != 0,
            disable:
                row['disable'] == null ? null : (row['disable'] as int) != 0,
            insertApp: row['insert_app'] == null
                ? null
                : (row['insert_app'] as int) != 0));
  }

  @override
  Future<List<Annotation>?> findAnnotationDisable() async {
    return _queryAdapter.queryList('SELECT * FROM annotation where disable = 1',
        mapper: (Map<String, Object?> row) => Annotation(
            id: row['id'] as int?,
            title: row['title'] as String?,
            text: row['text'] as String?,
            dateText: row['date_text'] as String?,
            idRevision: row['id_revision'] as int?,
            sync: row['sync'] == null ? null : (row['sync'] as int) != 0,
            disable:
                row['disable'] == null ? null : (row['disable'] as int) != 0,
            insertApp: row['insert_app'] == null
                ? null
                : (row['insert_app'] as int) != 0));
  }

  @override
  Future<void> deleteTable() async {
    await _queryAdapter.queryNoReturn('delete from annotation');
  }

  @override
  Future<int> insertAnnotation(Annotation annotationEntity) {
    return _annotationInsertionAdapter.insertAndReturnId(
        annotationEntity, OnConflictStrategy.abort);
  }

  @override
  Future<List<int>> insertAnnotationList(List<Annotation> annotationEntity) {
    return _annotationInsertionAdapter.insertListAndReturnIds(
        annotationEntity, OnConflictStrategy.abort);
  }

  @override
  Future<int> updateAnnotation(Annotation annotationEntity) {
    return _annotationUpdateAdapter.updateAndReturnChangedRows(
        annotationEntity, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateAnnotationList(List<Annotation> annotation) async {
    await _annotationUpdateAdapter.updateList(
        annotation, OnConflictStrategy.abort);
  }
}

class _$QuizDao extends QuizDao {
  _$QuizDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _quizInsertionAdapter = InsertionAdapter(
            database,
            'quiz',
            (Quiz item) => <String, Object?>{
                  'id': item.id,
                  'topic': item.topic,
                  'description': item.description,
                  'sync': item.sync == null ? null : (item.sync! ? 1 : 0),
                  'disable':
                      item.disable == null ? null : (item.disable! ? 1 : 0),
                  'insert_app':
                      item.insertApp == null ? null : (item.insertApp! ? 1 : 0)
                }),
        _quizUpdateAdapter = UpdateAdapter(
            database,
            'quiz',
            ['id'],
            (Quiz item) => <String, Object?>{
                  'id': item.id,
                  'topic': item.topic,
                  'description': item.description,
                  'sync': item.sync == null ? null : (item.sync! ? 1 : 0),
                  'disable':
                      item.disable == null ? null : (item.disable! ? 1 : 0),
                  'insert_app':
                      item.insertApp == null ? null : (item.insertApp! ? 1 : 0)
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Quiz> _quizInsertionAdapter;

  final UpdateAdapter<Quiz> _quizUpdateAdapter;

  @override
  Future<List<Quiz>?> getAllQuiz() async {
    return _queryAdapter.queryList('SELECT * FROM quiz where disable = 0',
        mapper: (Map<String, Object?> row) => Quiz(
            id: row['id'] as int?,
            topic: row['topic'] as String?,
            description: row['description'] as String?,
            sync: row['sync'] == null ? null : (row['sync'] as int) != 0,
            disable:
                row['disable'] == null ? null : (row['disable'] as int) != 0,
            insertApp: row['insert_app'] == null
                ? null
                : (row['insert_app'] as int) != 0));
  }

  @override
  Future<List<Quiz>?> findAllQuizSync() async {
    return _queryAdapter.queryList(
        'SELECT * FROM quiz where sync = 0 and disable = 0',
        mapper: (Map<String, Object?> row) => Quiz(
            id: row['id'] as int?,
            topic: row['topic'] as String?,
            description: row['description'] as String?,
            sync: row['sync'] == null ? null : (row['sync'] as int) != 0,
            disable:
                row['disable'] == null ? null : (row['disable'] as int) != 0,
            insertApp: row['insert_app'] == null
                ? null
                : (row['insert_app'] as int) != 0));
  }

  @override
  Future<List<Quiz>?> getAllQuizSearch(String text) async {
    return _queryAdapter.queryList(
        'SELECT * FROM quiz where topic LIKE ?1 and disable = 0',
        mapper: (Map<String, Object?> row) => Quiz(
            id: row['id'] as int?,
            topic: row['topic'] as String?,
            description: row['description'] as String?,
            sync: row['sync'] == null ? null : (row['sync'] as int) != 0,
            disable:
                row['disable'] == null ? null : (row['disable'] as int) != 0,
            insertApp: row['insert_app'] == null
                ? null
                : (row['insert_app'] as int) != 0),
        arguments: [text]);
  }

  @override
  Future<List<Quiz>?> findQuizDisable() async {
    return _queryAdapter.queryList('SELECT * FROM quiz where disable = 1',
        mapper: (Map<String, Object?> row) => Quiz(
            id: row['id'] as int?,
            topic: row['topic'] as String?,
            description: row['description'] as String?,
            sync: row['sync'] == null ? null : (row['sync'] as int) != 0,
            disable:
                row['disable'] == null ? null : (row['disable'] as int) != 0,
            insertApp: row['insert_app'] == null
                ? null
                : (row['insert_app'] as int) != 0));
  }

  @override
  Future<Quiz?> getQuizById(int id) async {
    return _queryAdapter.query('SELECT * FROM quiz WHERE id = ?1',
        mapper: (Map<String, Object?> row) => Quiz(
            id: row['id'] as int?,
            topic: row['topic'] as String?,
            description: row['description'] as String?,
            sync: row['sync'] == null ? null : (row['sync'] as int) != 0,
            disable:
                row['disable'] == null ? null : (row['disable'] as int) != 0,
            insertApp: row['insert_app'] == null
                ? null
                : (row['insert_app'] as int) != 0),
        arguments: [id]);
  }

  @override
  Future<Quiz?> disableQuiz(int id) async {
    return _queryAdapter.query('update quiz set disable = 1 WHERE id = ?1',
        mapper: (Map<String, Object?> row) => Quiz(
            id: row['id'] as int?,
            topic: row['topic'] as String?,
            description: row['description'] as String?,
            sync: row['sync'] == null ? null : (row['sync'] as int) != 0,
            disable:
                row['disable'] == null ? null : (row['disable'] as int) != 0,
            insertApp: row['insert_app'] == null
                ? null
                : (row['insert_app'] as int) != 0),
        arguments: [id]);
  }

  @override
  Future<void> deleteTable() async {
    await _queryAdapter.queryNoReturn('delete from quiz');
  }

  @override
  Future<int> insertQuiz(Quiz quiz) {
    return _quizInsertionAdapter.insertAndReturnId(
        quiz, OnConflictStrategy.abort);
  }

  @override
  Future<List<int>> insertQuizList(List<Quiz> quiz) {
    return _quizInsertionAdapter.insertListAndReturnIds(
        quiz, OnConflictStrategy.abort);
  }

  @override
  Future<int> updateQuiz(Quiz quiz) {
    return _quizUpdateAdapter.updateAndReturnChangedRows(
        quiz, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateQuizList(List<Quiz> quiz) async {
    await _quizUpdateAdapter.updateList(quiz, OnConflictStrategy.abort);
  }
}

class _$QuestionDao extends QuestionDao {
  _$QuestionDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _questionInsertionAdapter = InsertionAdapter(
            database,
            'question',
            (Question item) => <String, Object?>{
                  'id': item.id,
                  'id_quiz': item.idQuiz,
                  'description': item.description,
                  'answer': item.answer == null ? null : (item.answer! ? 1 : 0),
                  'sync': item.sync == null ? null : (item.sync! ? 1 : 0),
                  'disable':
                      item.disable == null ? null : (item.disable! ? 1 : 0),
                  'insert_app':
                      item.insertApp == null ? null : (item.insertApp! ? 1 : 0)
                }),
        _questionUpdateAdapter = UpdateAdapter(
            database,
            'question',
            ['id'],
            (Question item) => <String, Object?>{
                  'id': item.id,
                  'id_quiz': item.idQuiz,
                  'description': item.description,
                  'answer': item.answer == null ? null : (item.answer! ? 1 : 0),
                  'sync': item.sync == null ? null : (item.sync! ? 1 : 0),
                  'disable':
                      item.disable == null ? null : (item.disable! ? 1 : 0),
                  'insert_app':
                      item.insertApp == null ? null : (item.insertApp! ? 1 : 0)
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Question> _questionInsertionAdapter;

  final UpdateAdapter<Question> _questionUpdateAdapter;

  @override
  Future<List<Question>?> getAllQuestion() async {
    return _queryAdapter.queryList('SELECT * FROM question',
        mapper: (Map<String, Object?> row) => Question(
            id: row['id'] as int?,
            idQuiz: row['id_quiz'] as int?,
            description: row['description'] as String?,
            answer: row['answer'] == null ? null : (row['answer'] as int) != 0,
            sync: row['sync'] == null ? null : (row['sync'] as int) != 0,
            disable:
                row['disable'] == null ? null : (row['disable'] as int) != 0,
            insertApp: row['insert_app'] == null
                ? null
                : (row['insert_app'] as int) != 0));
  }

  @override
  Future<List<Question>?> findAllQuestionSync() async {
    return _queryAdapter.queryList(
        'SELECT * FROM question where sync = 0 and disable = 0',
        mapper: (Map<String, Object?> row) => Question(
            id: row['id'] as int?,
            idQuiz: row['id_quiz'] as int?,
            description: row['description'] as String?,
            answer: row['answer'] == null ? null : (row['answer'] as int) != 0,
            sync: row['sync'] == null ? null : (row['sync'] as int) != 0,
            disable:
                row['disable'] == null ? null : (row['disable'] as int) != 0,
            insertApp: row['insert_app'] == null
                ? null
                : (row['insert_app'] as int) != 0));
  }

  @override
  Future<Question?> getQuestionById(int id) async {
    return _queryAdapter.query(
        'SELECT * FROM question WHERE id = ?1 and disable = 0',
        mapper: (Map<String, Object?> row) => Question(
            id: row['id'] as int?,
            idQuiz: row['id_quiz'] as int?,
            description: row['description'] as String?,
            answer: row['answer'] == null ? null : (row['answer'] as int) != 0,
            sync: row['sync'] == null ? null : (row['sync'] as int) != 0,
            disable:
                row['disable'] == null ? null : (row['disable'] as int) != 0,
            insertApp: row['insert_app'] == null
                ? null
                : (row['insert_app'] as int) != 0),
        arguments: [id]);
  }

  @override
  Future<List<Question>?> getQuestionByIdQuiz(int idQuiz) async {
    return _queryAdapter.queryList(
        'SELECT * FROM question WHERE id_quiz = ?1 and disable = 0',
        mapper: (Map<String, Object?> row) => Question(
            id: row['id'] as int?,
            idQuiz: row['id_quiz'] as int?,
            description: row['description'] as String?,
            answer: row['answer'] == null ? null : (row['answer'] as int) != 0,
            sync: row['sync'] == null ? null : (row['sync'] as int) != 0,
            disable:
                row['disable'] == null ? null : (row['disable'] as int) != 0,
            insertApp: row['insert_app'] == null
                ? null
                : (row['insert_app'] as int) != 0),
        arguments: [idQuiz]);
  }

  @override
  Future<List<Question>?> findQuestionDisable() async {
    return _queryAdapter.queryList('SELECT * FROM question where disable = 1',
        mapper: (Map<String, Object?> row) => Question(
            id: row['id'] as int?,
            idQuiz: row['id_quiz'] as int?,
            description: row['description'] as String?,
            answer: row['answer'] == null ? null : (row['answer'] as int) != 0,
            sync: row['sync'] == null ? null : (row['sync'] as int) != 0,
            disable:
                row['disable'] == null ? null : (row['disable'] as int) != 0,
            insertApp: row['insert_app'] == null
                ? null
                : (row['insert_app'] as int) != 0));
  }

  @override
  Future<void> disableQuestion(int id) async {
    await _queryAdapter.queryNoReturn(
        'update question set disable = 1 WHERE id = ?1',
        arguments: [id]);
  }

  @override
  Future<void> disableQuestionByIdQuiz(int idQuiz) async {
    await _queryAdapter.queryNoReturn(
        'update question set disable = 1 WHERE id_quiz = ?1',
        arguments: [idQuiz]);
  }

  @override
  Future<void> deleteTable() async {
    await _queryAdapter.queryNoReturn('delete from question');
  }

  @override
  Future<int> insertQuestion(Question question) {
    return _questionInsertionAdapter.insertAndReturnId(
        question, OnConflictStrategy.abort);
  }

  @override
  Future<List<int>> insertQuestionList(List<Question> question) {
    return _questionInsertionAdapter.insertListAndReturnIds(
        question, OnConflictStrategy.abort);
  }

  @override
  Future<int> updateQuestion(Question question) {
    return _questionUpdateAdapter.updateAndReturnChangedRows(
        question, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateQuestionList(List<Question> question) async {
    await _questionUpdateAdapter.updateList(question, OnConflictStrategy.abort);
  }
}

class _$SettingDao extends SettingDao {
  _$SettingDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _settingsInsertionAdapter = InsertionAdapter(
            database,
            'setting',
            (Settings item) => <String, Object?>{
                  'id': item.id,
                  'keystone': item.key,
                  'value': item.value
                }),
        _settingsUpdateAdapter = UpdateAdapter(
            database,
            'setting',
            ['id'],
            (Settings item) => <String, Object?>{
                  'id': item.id,
                  'keystone': item.key,
                  'value': item.value
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Settings> _settingsInsertionAdapter;

  final UpdateAdapter<Settings> _settingsUpdateAdapter;

  @override
  Future<Settings?> findSettingByKey(String key) async {
    return _queryAdapter.query('select * from setting where keystone = ?1',
        mapper: (Map<String, Object?> row) => Settings(
            id: row['id'] as int?,
            key: row['keystone'] as String?,
            value: row['value'] as String?),
        arguments: [key]);
  }

  @override
  Future<int> insertSetting(Settings settings) {
    return _settingsInsertionAdapter.insertAndReturnId(
        settings, OnConflictStrategy.abort);
  }

  @override
  Future<int> updateSetting(Settings settings) {
    return _settingsUpdateAdapter.updateAndReturnChangedRows(
        settings, OnConflictStrategy.abort);
  }
}

class _$UserDao extends UserDao {
  _$UserDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _userInsertionAdapter = InsertionAdapter(
            database,
            'user',
            (User item) => <String, Object?>{
                  'email': item.email,
                  'password': item.password
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<User> _userInsertionAdapter;

  @override
  Future<User?> findByEmailAndPassword(
    String email,
    String password,
  ) async {
    return _queryAdapter.query(
        'select * from user where email = ?1 and password = ?2',
        mapper: (Map<String, Object?> row) =>
            User(row['email'] as String, row['password'] as String),
        arguments: [email, password]);
  }

  @override
  Future<User?> findByEmail(String email) async {
    return _queryAdapter.query('select * from user where email = ?1',
        mapper: (Map<String, Object?> row) =>
            User(row['email'] as String, row['password'] as String),
        arguments: [email]);
  }

  @override
  Future<int?> tableUserContainsRegister() async {
    return _queryAdapter.query('select count(email) from user',
        mapper: (Map<String, Object?> row) => row.values.first as int);
  }

  @override
  Future<void> register(User user) async {
    await _userInsertionAdapter.insert(user, OnConflictStrategy.abort);
  }
}

class _$RevisionQuizDao extends RevisionQuizDao {
  _$RevisionQuizDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _revisionQuizInsertionAdapter = InsertionAdapter(
            database,
            'revision_quiz',
            (RevisionQuiz item) => <String, Object?>{
                  'id': item.id,
                  'date_revision': item.dateRevision,
                  'answer': item.answer == null ? null : (item.answer! ? 1 : 0),
                  'id_quiz': item.idQuiz,
                  'sync': item.sync == null ? null : (item.sync! ? 1 : 0),
                  'disable':
                      item.disable == null ? null : (item.disable! ? 1 : 0),
                  'insert_app':
                      item.insertApp == null ? null : (item.insertApp! ? 1 : 0)
                }),
        _revisionQuizUpdateAdapter = UpdateAdapter(
            database,
            'revision_quiz',
            ['id'],
            (RevisionQuiz item) => <String, Object?>{
                  'id': item.id,
                  'date_revision': item.dateRevision,
                  'answer': item.answer == null ? null : (item.answer! ? 1 : 0),
                  'id_quiz': item.idQuiz,
                  'sync': item.sync == null ? null : (item.sync! ? 1 : 0),
                  'disable':
                      item.disable == null ? null : (item.disable! ? 1 : 0),
                  'insert_app':
                      item.insertApp == null ? null : (item.insertApp! ? 1 : 0)
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<RevisionQuiz> _revisionQuizInsertionAdapter;

  final UpdateAdapter<RevisionQuiz> _revisionQuizUpdateAdapter;

  @override
  Future<List<RevisionQuiz>?> getAllRevisionQuiz() async {
    return _queryAdapter.queryList(
        'SELECT * FROM revision_quiz where disable = 0',
        mapper: (Map<String, Object?> row) => RevisionQuiz(
            id: row['id'] as int?,
            dateRevision: row['date_revision'] as String?,
            answer: row['answer'] == null ? null : (row['answer'] as int) != 0,
            idQuiz: row['id_quiz'] as int?,
            sync: row['sync'] == null ? null : (row['sync'] as int) != 0,
            disable:
                row['disable'] == null ? null : (row['disable'] as int) != 0,
            insertApp: row['insert_app'] == null
                ? null
                : (row['insert_app'] as int) != 0));
  }

  @override
  Future<List<RevisionQuiz>?> findAllRevisionQuizSync() async {
    return _queryAdapter.queryList(
        'SELECT * FROM revision_quiz where sync = 0 and disable = 0',
        mapper: (Map<String, Object?> row) => RevisionQuiz(
            id: row['id'] as int?,
            dateRevision: row['date_revision'] as String?,
            answer: row['answer'] == null ? null : (row['answer'] as int) != 0,
            idQuiz: row['id_quiz'] as int?,
            sync: row['sync'] == null ? null : (row['sync'] as int) != 0,
            disable:
                row['disable'] == null ? null : (row['disable'] as int) != 0,
            insertApp: row['insert_app'] == null
                ? null
                : (row['insert_app'] as int) != 0));
  }

  @override
  Future<RevisionQuiz?> getRevisionQuizById(int id) async {
    return _queryAdapter.query(
        'SELECT * FROM revision_quiz WHERE id = ?1 and disable = 0',
        mapper: (Map<String, Object?> row) => RevisionQuiz(
            id: row['id'] as int?,
            dateRevision: row['date_revision'] as String?,
            answer: row['answer'] == null ? null : (row['answer'] as int) != 0,
            idQuiz: row['id_quiz'] as int?,
            sync: row['sync'] == null ? null : (row['sync'] as int) != 0,
            disable:
                row['disable'] == null ? null : (row['disable'] as int) != 0,
            insertApp: row['insert_app'] == null
                ? null
                : (row['insert_app'] as int) != 0),
        arguments: [id]);
  }

  @override
  Future<List<RevisionQuiz>?> getRevisionQuizByIdQuiz(int idQuiz) async {
    return _queryAdapter.queryList(
        'SELECT * FROM revision_quiz WHERE id_quiz = ?1 and disable = 0',
        mapper: (Map<String, Object?> row) => RevisionQuiz(
            id: row['id'] as int?,
            dateRevision: row['date_revision'] as String?,
            answer: row['answer'] == null ? null : (row['answer'] as int) != 0,
            idQuiz: row['id_quiz'] as int?,
            sync: row['sync'] == null ? null : (row['sync'] as int) != 0,
            disable:
                row['disable'] == null ? null : (row['disable'] as int) != 0,
            insertApp: row['insert_app'] == null
                ? null
                : (row['insert_app'] as int) != 0),
        arguments: [idQuiz]);
  }

  @override
  Future<List<RevisionQuiz>?> findRevisionQuizDisable() async {
    return _queryAdapter.queryList(
        'SELECT * FROM revision_quiz where disable = 1',
        mapper: (Map<String, Object?> row) => RevisionQuiz(
            id: row['id'] as int?,
            dateRevision: row['date_revision'] as String?,
            answer: row['answer'] == null ? null : (row['answer'] as int) != 0,
            idQuiz: row['id_quiz'] as int?,
            sync: row['sync'] == null ? null : (row['sync'] as int) != 0,
            disable:
                row['disable'] == null ? null : (row['disable'] as int) != 0,
            insertApp: row['insert_app'] == null
                ? null
                : (row['insert_app'] as int) != 0));
  }

  @override
  Future<RevisionQuiz?> disableRevisionQuiz(int id) async {
    return _queryAdapter.query(
        'update revision_quiz set disable = 1 WHERE id = ?1',
        mapper: (Map<String, Object?> row) => RevisionQuiz(
            id: row['id'] as int?,
            dateRevision: row['date_revision'] as String?,
            answer: row['answer'] == null ? null : (row['answer'] as int) != 0,
            idQuiz: row['id_quiz'] as int?,
            sync: row['sync'] == null ? null : (row['sync'] as int) != 0,
            disable:
                row['disable'] == null ? null : (row['disable'] as int) != 0,
            insertApp: row['insert_app'] == null
                ? null
                : (row['insert_app'] as int) != 0),
        arguments: [id]);
  }

  @override
  Future<void> disableRevisionQuizByIdQuiz(int idQuiz) async {
    await _queryAdapter.queryNoReturn(
        'update revision_quiz set disable = 1 WHERE id_quiz = ?1',
        arguments: [idQuiz]);
  }

  @override
  Future<void> deleteTable() async {
    await _queryAdapter.queryNoReturn('delete from revision_quiz');
  }

  @override
  Future<int> insertRevisionQuiz(RevisionQuiz revisionQuiz) {
    return _revisionQuizInsertionAdapter.insertAndReturnId(
        revisionQuiz, OnConflictStrategy.abort);
  }

  @override
  Future<void> insertRevisionQuizList(List<RevisionQuiz> revisionQuiz) async {
    await _revisionQuizInsertionAdapter.insertList(
        revisionQuiz, OnConflictStrategy.abort);
  }

  @override
  Future<int> updateRevisionQuiz(RevisionQuiz revisionQuiz) {
    return _revisionQuizUpdateAdapter.updateAndReturnChangedRows(
        revisionQuiz, OnConflictStrategy.abort);
  }

  @override
  Future<void> updateRevisionQuizList(List<RevisionQuiz> revisionQuiz) async {
    await _revisionQuizUpdateAdapter.updateList(
        revisionQuiz, OnConflictStrategy.abort);
  }
}

class _$RevisionThemeDao extends RevisionThemeDao {
  _$RevisionThemeDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _revisionThemeInsertionAdapter = InsertionAdapter(
            database,
            'revision_theme',
            (RevisionTheme item) => <String, Object?>{
                  'id': item.id,
                  'description': item.description,
                  'sync': item.sync == null ? null : (item.sync! ? 1 : 0),
                  'disable':
                      item.disable == null ? null : (item.disable! ? 1 : 0),
                  'insert_app':
                      item.insertApp == null ? null : (item.insertApp! ? 1 : 0)
                }),
        _revisionThemeUpdateAdapter = UpdateAdapter(
            database,
            'revision_theme',
            ['id'],
            (RevisionTheme item) => <String, Object?>{
                  'id': item.id,
                  'description': item.description,
                  'sync': item.sync == null ? null : (item.sync! ? 1 : 0),
                  'disable':
                      item.disable == null ? null : (item.disable! ? 1 : 0),
                  'insert_app':
                      item.insertApp == null ? null : (item.insertApp! ? 1 : 0)
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<RevisionTheme> _revisionThemeInsertionAdapter;

  final UpdateAdapter<RevisionTheme> _revisionThemeUpdateAdapter;

  @override
  Future<List<RevisionTheme>> findAllRevisionTheme() async {
    return _queryAdapter.queryList('SELECT * FROM revision_theme',
        mapper: (Map<String, Object?> row) => RevisionTheme(
            id: row['id'] as int?,
            description: row['description'] as String?,
            sync: row['sync'] == null ? null : (row['sync'] as int) != 0,
            disable:
                row['disable'] == null ? null : (row['disable'] as int) != 0,
            insertApp: row['insert_app'] == null
                ? null
                : (row['insert_app'] as int) != 0));
  }

  @override
  Future<List<RevisionTheme>?> findAllRevisionThemeSync() async {
    return _queryAdapter.queryList(
        'SELECT * FROM revision_theme where sync = 0 and disable = 0',
        mapper: (Map<String, Object?> row) => RevisionTheme(
            id: row['id'] as int?,
            description: row['description'] as String?,
            sync: row['sync'] == null ? null : (row['sync'] as int) != 0,
            disable:
                row['disable'] == null ? null : (row['disable'] as int) != 0,
            insertApp: row['insert_app'] == null
                ? null
                : (row['insert_app'] as int) != 0));
  }

  @override
  Future<List<RevisionTheme>?> findRevisionThemeDisable() async {
    return _queryAdapter.queryList(
        'SELECT * FROM revision_theme where disable = 1',
        mapper: (Map<String, Object?> row) => RevisionTheme(
            id: row['id'] as int?,
            description: row['description'] as String?,
            sync: row['sync'] == null ? null : (row['sync'] as int) != 0,
            disable:
                row['disable'] == null ? null : (row['disable'] as int) != 0,
            insertApp: row['insert_app'] == null
                ? null
                : (row['insert_app'] as int) != 0));
  }

  @override
  Future<RevisionTheme?> findRevisionThemeById(int id) async {
    return _queryAdapter.query('SELECT * FROM revision_theme WHERE id = ?1',
        mapper: (Map<String, Object?> row) => RevisionTheme(
            id: row['id'] as int?,
            description: row['description'] as String?,
            sync: row['sync'] == null ? null : (row['sync'] as int) != 0,
            disable:
                row['disable'] == null ? null : (row['disable'] as int) != 0,
            insertApp: row['insert_app'] == null
                ? null
                : (row['insert_app'] as int) != 0),
        arguments: [id]);
  }

  @override
  Future<RevisionTheme?> disableRevisionThemeById(int id) async {
    return _queryAdapter.query(
        'update revision_theme set disable = 1 WHERE id = ?1',
        mapper: (Map<String, Object?> row) => RevisionTheme(
            id: row['id'] as int?,
            description: row['description'] as String?,
            sync: row['sync'] == null ? null : (row['sync'] as int) != 0,
            disable:
                row['disable'] == null ? null : (row['disable'] as int) != 0,
            insertApp: row['insert_app'] == null
                ? null
                : (row['insert_app'] as int) != 0),
        arguments: [id]);
  }

  @override
  Future<List<RevisionTheme>> findRevisionThemeByDescription(
      String text) async {
    return _queryAdapter.queryList(
        'SELECT * FROM revision_theme WHERE description LIKE ?1',
        mapper: (Map<String, Object?> row) => RevisionTheme(
            id: row['id'] as int?,
            description: row['description'] as String?,
            sync: row['sync'] == null ? null : (row['sync'] as int) != 0,
            disable:
                row['disable'] == null ? null : (row['disable'] as int) != 0,
            insertApp: row['insert_app'] == null
                ? null
                : (row['insert_app'] as int) != 0),
        arguments: [text]);
  }

  @override
  Future<void> deleteTable() async {
    await _queryAdapter.queryNoReturn('delete from revision_theme');
  }

  @override
  Future<int> insertRevisionTheme(RevisionTheme revisionTheme) {
    return _revisionThemeInsertionAdapter.insertAndReturnId(
        revisionTheme, OnConflictStrategy.abort);
  }

  @override
  Future<List<int>> insertRevisionThemeList(
      List<RevisionTheme> revisionThemes) {
    return _revisionThemeInsertionAdapter.insertListAndReturnIds(
        revisionThemes, OnConflictStrategy.abort);
  }

  @override
  Future<int> updateRevisionTheme(RevisionTheme revisionTheme) {
    return _revisionThemeUpdateAdapter.updateAndReturnChangedRows(
        revisionTheme, OnConflictStrategy.abort);
  }

  @override
  Future<int> updateRevisionThemeList(List<RevisionTheme> revisionThemes) {
    return _revisionThemeUpdateAdapter.updateListAndReturnChangedRows(
        revisionThemes, OnConflictStrategy.abort);
  }
}

class _$SessionDao extends SessionDao {
  _$SessionDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _sessionInsertionAdapter = InsertionAdapter(
            database,
            'session',
            (Session item) => <String, Object?>{
                  'id': item.id,
                  'email_user': item.emailUser,
                  'token': item.token
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<Session> _sessionInsertionAdapter;

  @override
  Future<void> delete() async {
    await _queryAdapter.queryNoReturn('delete from session');
  }

  @override
  Future<Session?> findSession() async {
    return _queryAdapter.query('select * from session',
        mapper: (Map<String, Object?> row) =>
            Session(row['email_user'] as String, row['token'] as String));
  }

  @override
  Future<int> register(Session session) {
    return _sessionInsertionAdapter.insertAndReturnId(
        session, OnConflictStrategy.abort);
  }
}

class _$LastSessionDao extends LastSessionDao {
  _$LastSessionDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _lastSessionInsertionAdapter = InsertionAdapter(
            database,
            'last_session',
            (LastSession item) =>
                <String, Object?>{'id': item.id, 'email': item.email}),
        _lastSessionUpdateAdapter = UpdateAdapter(
            database,
            'last_session',
            ['id'],
            (LastSession item) =>
                <String, Object?>{'id': item.id, 'email': item.email});

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<LastSession> _lastSessionInsertionAdapter;

  final UpdateAdapter<LastSession> _lastSessionUpdateAdapter;

  @override
  Future<LastSession?> findLastSession() async {
    return _queryAdapter.query('select * from last_session',
        mapper: (Map<String, Object?> row) =>
            LastSession(row['email'] as String));
  }

  @override
  Future<void> register(LastSession lastSession) async {
    await _lastSessionInsertionAdapter.insert(
        lastSession, OnConflictStrategy.abort);
  }

  @override
  Future<void> update(LastSession lastSession) async {
    await _lastSessionUpdateAdapter.update(
        lastSession, OnConflictStrategy.abort);
  }
}
