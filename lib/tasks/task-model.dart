import 'package:scoped_model/scoped_model.dart';

class Task extends Model {

  int _id = -1;
  String _name = "";
  String _description = "";
  DateTime _created;
  DateTime _due;
  TaskStatus _status;

  Task(this._id, this._name, this._description, this._created, this._due, this._status);

  Task.createNew(String name, {String description})
    : this(-1, name, description, DateTime.now(), null, TaskStatus.not_started);

  Task.fromMap(Map<String, dynamic> record) {
    this._id = record["id"];
    this._name = record["name"];
    this._description = record["description"];
  }

}

enum TaskStatus {
  not_started,
  in_progress,
  complete,
  abandoned
}
