import 'package:flutter/material.dart';
import 'package:task_app/models/task_controller.dart';
import 'package:task_app/widgets/widget_task.dart';
import 'package:provider/provider.dart';
import 'package:task_app/widgets/widget_showtaskdialog.dart'; 

class CompletedTasks extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Obtiene la instancia de TaskProvider
    final taskProvider = Provider.of<TaskProvider>(context);
    List<Task> completedTasks = taskProvider.tasks.where((task) => task.completed).toList();

    if (completedTasks.isEmpty) {
      return Center(
        child: Text(
          'No has completado ninguna tarea',
          style: TextStyle(fontSize: 18.0),
        ),
      );
    }

    return ListView.builder(
      itemCount: completedTasks.length,
      itemBuilder: (context, index) {
        bool isCompleted = completedTasks[index].completed;

        return GestureDetector(
          onTap: () {
            showTaskDetailsDialog( // Utiliza la función importada
              context,
              completedTasks[index].taskName,
              completedTasks[index].taskType,
              completedTasks[index].startDate,
              completedTasks[index].dueDate,
            );
          },
          child: TaskWidget(
            taskName: completedTasks[index].taskName,
            taskType: completedTasks[index].taskType,
            onDelete: () {
              taskProvider.removeTask(taskProvider.tasks.indexOf(completedTasks[index]));
            },
            isCompleted: isCompleted,
            onCheckboxChanged: (value) {
              taskProvider.toggleTaskCompletion(taskProvider.tasks.indexOf(completedTasks[index]));
            },
          ),
        );
      },
    );
  }
}
