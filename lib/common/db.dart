
import 'dart:async';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Db {

  static final Db _singleton = Db._internal();
  static final databaseVersion = 1;
  static Database _database;

  // Private constructor for singleton
  Db._internal();

  // Factory constuctor returns singleton instance
  factory Db() {
    return _singleton;
  }

  Future<Database> get database async {
    if (_database == null) {
      _database = await openDatabase(
        join(await getDatabasesPath(), 'tasks.db'),
        onCreate: this._createDatabase,
        version: 1
      );
    }
    return _database;
  }

  FutureOr<void> _createDatabase(Database database, int version) async {
    database.execute(
      "CREATE TABLE tasks(id INTEGER PRIMARY KEY, name TEXT, description TEXT, created INTEGER, due INTEGER, status INTEGER)"
    );
  }

}