class TaskController {
  static final TaskController _instance = TaskController._internal();
  List<Task> _tasks = [];

  factory TaskController() {
    return _instance;
  }

  TaskController._internal();

  List<Task> get tasks => _tasks;

  void addTask(Task task) {
    _tasks.add(task);
  }

  void toggleTaskCompletion(int index) {
    _tasks[index].completed = !_tasks[index].completed;
  }

  void removeTask(int index) {
    _tasks.removeAt(index);
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
