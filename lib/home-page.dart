import 'package:flutter/material.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:tasks_sql/tasks/task-list-model.dart';

class MyHomePage extends StatelessWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  Widget build(BuildContext context) {
    return ScopedModel<TaskList>(
      model: TaskList(),
      child: Scaffold(
        appBar: AppBar(title: Text(this.title)),
        body: ScopedModelDescendant<TaskList> (
          builder: this._buildTaskList
        ),
        floatingActionButton: 
          ScopedModelDescendant<TaskList>(
            builder: (ctx, child, model) {
              return FloatingActionButton(
                // onPressed: () async => await model.query("Search query"),
                onPressed: () async => await model.add('Task 1', 'The thing'),
                tooltip: 'Increment', 
                child: Icon(Icons.add)
              );
            },
          )
      ),
    );
  }

  Widget _buildTaskList(context, child, TaskList model) {
    return ListView (
      children: model.tasks.map((task) => 
        ListTile(
          title: Text(task.name),
        )
      ).toList()
    );
  }
}
