import 'package:flutter/foundation.dart';

class TaskProvider extends ChangeNotifier {
  List<Task> _tasks = [];

  List<Task> get tasks => _tasks;

  void addTask(Task task) {
    _tasks.add(task);
    notifyListeners(); // Notifica a los oyentes que se ha agregado una nueva tarea
  }

  void toggleTaskCompletion(int index) {
    _tasks[index].completed = !_tasks[index].completed;
    notifyListeners(); // Notifica a los oyentes que se ha cambiado el estado de una tarea
  }

  void removeTask(int index) {
    _tasks.removeAt(index);
    notifyListeners(); // Notifica a los oyentes que se ha eliminado una tarea
  }
}

class Task {
  final String taskName;
  final String description;
  final DateTime startDate;
  final DateTime dueDate;
  final String taskType;
  bool completed;

  Task({
    required this.taskName,
    required this.description,
    required this.startDate,
    required this.dueDate,
    required this.taskType,
    this.completed = false,
  });
}
