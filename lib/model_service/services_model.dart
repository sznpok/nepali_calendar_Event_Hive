import 'package:hive/hive.dart';
import 'package:flutter/material.dart';
import 'package:task_calendar/model/task.dart';

const hiveBox = 'task_box';

class ServiceModel with ChangeNotifier {
  List<Task> _listTask = <Task>[];
  List<Task> get getListTask => _listTask;

  addItem(Task task) async {
    var box = Hive.box<Task>(hiveBox);
    box.add(task);
    print('added');
    notifyListeners();
  }

  getTask() async {
    final box = Hive.box<Task>(hiveBox);
    _listTask = box.values.toList();
    notifyListeners();
    print("all data fetched");
  }

  updateTask(int index, Task task) async {
    final box = Hive.box<Task>(hiveBox);
    box.putAt(index, task);
    print('updated');
    notifyListeners();
  }

  deleteTask(int index) {
    final box = Hive.box<Task>(hiveBox);
    box.deleteAt(index);
    print('deleted');
    getTask();
    notifyListeners();
  }

  deleteAll(List<Task> task) {
    final box = Hive.box<Task>(hiveBox);
    box.clear();
    _listTask.clear();
    print('delete all');
    notifyListeners();
  }
}
