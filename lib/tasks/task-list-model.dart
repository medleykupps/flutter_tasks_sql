
import 'package:scoped_model/scoped_model.dart';
import 'package:tasks_sql/common/db.dart';
import 'package:tasks_sql/tasks/tasks-repository.dart';

import 'task-model.dart';

class TaskList extends Model {

  final tasks = new List<Task>();
  TasksRepository _repository;

  TaskList() {
    this._repository = new TasksRepository();
  }

  TaskList.withDependencies(this._repository);

  var _counter = 1;
  int get counter => _counter;
  void increment() {
    this._counter++;
    notifyListeners();
  }

  Future<Task> add(String name, String description) async {

    final id = await _repository.getNextId();

    final task = Task.createNew(name, id: id, description: description);
    
    final result = await _repository.insert(task);
    if (result) {
      tasks.add(task);
      notifyListeners();
    } else {
      // Handle error
    }

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

}