import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

class DataBs {
  List toDoList = [];
  final table = Hive.openBox("TasksTable");
  final _table = Hive.box("TasksTable");
  

  void createData() {
    toDoList = [
      ["write Task", false],
    ];
  }

  void getData() {
    toDoList = _table.get("TODOLIST");
  }

  void updateData() {
    _table.put("TODOLIST", toDoList);
  }


}
