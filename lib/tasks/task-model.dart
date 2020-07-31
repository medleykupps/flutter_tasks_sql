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

  Map<String, dynamic> toMap() {
    final attr = new Map<String, dynamic>();
    attr["id"] = this._id;
    attr["name"] = this._name;
    attr["description"] = this._description;
    attr["created"] = this._created == null ? 0 : (this._created.millisecondsSinceEpoch / 1000).floor();
    attr["due"] = this._due == null ? 0 : (this._due.millisecondsSinceEpoch / 1000).floor();
    attr["status"] = this._status.index;
    return attr;
  }

  void setId(int id) => this._id = id;
  String get name => _name;

}

enum TaskStatus {
  not_started,
  in_progress,
  complete,
  abandoned
}
