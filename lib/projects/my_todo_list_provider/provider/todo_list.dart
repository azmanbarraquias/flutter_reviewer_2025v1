import 'package:flutter/material.dart';

import '../modal/todo.dart';

class TodoList extends ChangeNotifier {
  final List<ToDo> _tasks = [];

  List<ToDo> get tasks => _tasks;

  List<ToDo> get completedTask => _tasks.where((task) => task.isCompleted).toList();

  List<ToDo> get pendingTask => _tasks.where((task) => !task.isCompleted).toList();

  void addTask(String description) {
    _tasks.add(ToDo(description: description));
    notifyListeners();
  }

  void markTaskCompleted(int index) {
    _tasks[index].isCompleted = true;
    notifyListeners();
  }


}