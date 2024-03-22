import 'package:flutter/material.dart';
import 'package:task_app/models/task_controller.dart';
import 'package:task_app/widgets/widget_task.dart';
import 'package:provider/provider.dart';
import 'package:task_app/widgets/widget_showtaskdialog.dart'; 

class ActiveTasksView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Obtiene la instancia de TaskProvider
    final taskProvider = Provider.of<TaskProvider>(context);

    List<Task> incompleteTasks = taskProvider.tasks.where((task) => !task.completed).toList();

    if (incompleteTasks.isEmpty) {
      return Center(
        child: Text(
          'No tienes tareas pendientes',
          style: TextStyle(fontSize: 18.0),
        ),
      );
    }

    return ListView.builder(
      itemCount: incompleteTasks.length,
      itemBuilder: (context, index) {
        bool isCompleted = incompleteTasks[index].completed;

        return GestureDetector(
          onTap: () {
            showTaskDetailsDialog( // Llama a la función showTaskDetailsDialog
              context,
              incompleteTasks[index].taskName,
              incompleteTasks[index].taskType,
              incompleteTasks[index].startDate,
              incompleteTasks[index].dueDate,
            );
          },
          child: TaskWidget(
            taskName: incompleteTasks[index].taskName,
            taskType: incompleteTasks[index].taskType,
            onDelete: () {
              taskProvider.removeTask(index);
            },
            isCompleted: isCompleted,
            onCheckboxChanged: (value) {
              taskProvider.toggleTaskCompletion(index);
            },
          ),
        );
      },
    );
  }
}