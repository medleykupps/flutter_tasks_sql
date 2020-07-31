
import 'package:scoped_model/scoped_model.dart';
import 'package:tasks_sql/common/db.dart';

import 'task-model.dart';

class TaskList extends Model {

  final tasks = new List<Task>();
  var _counter = 1;
  int get counter => _counter;
  void increment() {
    this._counter++;
    notifyListeners();
  }

  Future<Task> add(String name, String description) async {

    final db = await Db().database;

    final id = await _getNextId();
    final task = Task.createNew(name, description: description);
    task.setId(id);
    final attributes = task.toMap();

    final result = await db.insert("tasks", attributes);
    print('Inserted $name $result');

    tasks.add(task);
    notifyListeners();

    return task;
  }

  Future query(String nameFilter) async {

    // tasks.add(Task.createNew("Do the thing", description: "You gotta get this thing done!"));
    // tasks.add(Task.createNew("And this thing", description: "Make sure this is done too"));

    final db = await Db().database;

    final results = await db.query("tasks", 
      columns: ['id','name','description'], 
      where: '"name" = ?',
      whereArgs: [nameFilter]
    );

    tasks.clear();
    if (results.length > 0) {
      tasks.addAll(results.map((record) => Task.fromMap(record)));
    }

    notifyListeners();

  }

  Future<int> _getNextId() async {
    final results = await (await Db().database).rawQuery('SELECT MAX(id) AS id FROM "tasks"');
    if (results.length == 0) {
      return 1;
    }
    final id = results.first["id"];
    return id + 1;
  }
}