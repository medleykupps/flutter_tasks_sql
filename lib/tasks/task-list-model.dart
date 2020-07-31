
import 'package:scoped_model/scoped_model.dart';
import 'package:tasks_sql/common/db.dart';

import 'task-model.dart';

class TaskList extends Model {

  final _tasks = new List<Task>();
  var _counter = 1;
  int get counter => _counter;
  void increment() {
    this._counter++;
    notifyListeners();
  }

  void query(String nameFilter) async {

    final db = await Db().database;

    final results = await db.query("tasks", 
      columns: ['id','name','description'], 
      where: '"name" = ?',
      whereArgs: [nameFilter]
    );

    _tasks.clear();
    if (results.length > 0) {
      _tasks.addAll(results.map((record) => Task.fromMap(record)));
    }

    notifyListeners();

  }
}