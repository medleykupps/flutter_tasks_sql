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
        body: Column(children: <Widget>[
          ScopedModelDescendant<TaskList> (
            builder: (context, child, model) {
              return new Text('${model.counter}');
            },),
          Text("body"),
        ]),
        floatingActionButton: 
          ScopedModelDescendant<TaskList>(
            builder: (ctx, child, model) {
              return FloatingActionButton(
                onPressed: () => model.increment(),
                tooltip: 'Increment', 
                child: Icon(Icons.add)
              );
            },
          )
        
        
      ),
    );
  }
}
