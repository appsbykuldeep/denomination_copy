// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: library_private_types_in_public_api

part of 'local_db.dart';

// **************************************************************************
// FloorGenerator
// **************************************************************************

// ignore: avoid_classes_with_only_static_members
class $FloorAppDatabase {
  /// Creates a database builder for a persistent database.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder databaseBuilder(String name) =>
      _$AppDatabaseBuilder(name);

  /// Creates a database builder for an in memory database.
  /// Information stored in an in memory database disappears when the process is killed.
  /// Once a database is built, you should keep a reference to it and re-use it.
  static _$AppDatabaseBuilder inMemoryDatabaseBuilder() =>
      _$AppDatabaseBuilder(null);
}

class _$AppDatabaseBuilder {
  _$AppDatabaseBuilder(this.name);

  final String? name;

  final List<Migration> _migrations = [];

  Callback? _callback;

  /// Adds migrations to the builder.
  _$AppDatabaseBuilder addMigrations(List<Migration> migrations) {
    _migrations.addAll(migrations);
    return this;
  }

  /// Adds a database [Callback] to the builder.
  _$AppDatabaseBuilder addCallback(Callback callback) {
    _callback = callback;
    return this;
  }

  /// Creates the database and initializes it.
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

  SavedDenominationDao? _denominationDaoInstance;

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
            'CREATE TABLE IF NOT EXISTS `SavedDenomination` (`id` INTEGER PRIMARY KEY AUTOINCREMENT, `createOn` TEXT NOT NULL, `denoCategory` TEXT NOT NULL, `remark` TEXT NOT NULL, `denominationJsonStr` TEXT NOT NULL)');

        await callback?.onCreate?.call(database, version);
      },
    );
    return sqfliteDatabaseFactory.openDatabase(path, options: databaseOptions);
  }

  @override
  SavedDenominationDao get denominationDao {
    return _denominationDaoInstance ??=
        _$SavedDenominationDao(database, changeListener);
  }
}

class _$SavedDenominationDao extends SavedDenominationDao {
  _$SavedDenominationDao(
    this.database,
    this.changeListener,
  )   : _queryAdapter = QueryAdapter(database),
        _savedDenominationInsertionAdapter = InsertionAdapter(
            database,
            'SavedDenomination',
            (SavedDenomination item) => <String, Object?>{
                  'id': item.id,
                  'createOn': item.createOn,
                  'denoCategory': item.denoCategory,
                  'remark': item.remark,
                  'denominationJsonStr': item.denominationJsonStr
                }),
        _savedDenominationDeletionAdapter = DeletionAdapter(
            database,
            'SavedDenomination',
            ['id'],
            (SavedDenomination item) => <String, Object?>{
                  'id': item.id,
                  'createOn': item.createOn,
                  'denoCategory': item.denoCategory,
                  'remark': item.remark,
                  'denominationJsonStr': item.denominationJsonStr
                });

  final sqflite.DatabaseExecutor database;

  final StreamController<String> changeListener;

  final QueryAdapter _queryAdapter;

  final InsertionAdapter<SavedDenomination> _savedDenominationInsertionAdapter;

  final DeletionAdapter<SavedDenomination> _savedDenominationDeletionAdapter;

  @override
  Future<List<SavedDenomination>> findAllSavedDenominations() async {
    return _queryAdapter.queryList(
        'SELECT * FROM SavedDenomination order by id desc',
        mapper: (Map<String, Object?> row) => SavedDenomination(
            id: row['id'] as int?,
            createOn: row['createOn'] as String,
            denoCategory: row['denoCategory'] as String,
            remark: row['remark'] as String,
            denominationJsonStr: row['denominationJsonStr'] as String));
  }

  @override
  Future<SavedDenomination?> findSavedDenominationById(int id) async {
    return _queryAdapter.query('SELECT * FROM SavedDenomination WHERE id = ?1',
        mapper: (Map<String, Object?> row) => SavedDenomination(
            id: row['id'] as int?,
            createOn: row['createOn'] as String,
            denoCategory: row['denoCategory'] as String,
            remark: row['remark'] as String,
            denominationJsonStr: row['denominationJsonStr'] as String),
        arguments: [id]);
  }

  @override
  Future<int> insertSingleDenomination(SavedDenomination savedDenomination) {
    return _savedDenominationInsertionAdapter.insertAndReturnId(
        savedDenomination, OnConflictStrategy.replace);
  }

  @override
  Future<void> insertDenomination(
      List<SavedDenomination> savedDenomination) async {
    await _savedDenominationInsertionAdapter.insertList(
        savedDenomination, OnConflictStrategy.replace);
  }

  @override
  Future<void> removeSingleDeno(SavedDenomination data) async {
    await _savedDenominationDeletionAdapter.delete(data);
  }
}
