
import 'package:tasks_sql/common/db.dart';

import 'task-model.dart';

class TasksRepository {

  Future<int> getNextId() async {

    final db = await Db().database;

    final results = await db.rawQuery('SELECT MAX(id) AS id FROM "tasks"');
    if (results.length == 0) {
      return 1;
    }

    final id = results.first["id"];
    if (id < 0) {
      return 1;
    }

    return id + 1;
  }

  Future<bool> insert(Task task) async {

    final db = await Db().database;

    final attributes = task.toMap();

    final result = await db.insert("tasks", attributes);
    if (result == 1) {
      return true;
    }

    print('Error $result');
    return false;    
  }

}