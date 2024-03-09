import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:task_app/models/task_controller.dart';
import 'package:task_app/widgets/widget_task.dart';

class ActiveTasksView extends StatelessWidget {
  final TaskController taskController;
  final Function(int) toggleTaskCompletion;

  const ActiveTasksView({
    Key? key,
    required this.taskController,
    required this.toggleTaskCompletion,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Task> incompleteTasks = taskController.tasks.where((task) => !task.completed).toList();

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
            _showTaskDetailsDialog(
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
              taskController.removeTask(taskController.tasks.indexOf(incompleteTasks[index]));
            },
            isCompleted: isCompleted,
            onCheckboxChanged: (value) {
              toggleTaskCompletion(taskController.tasks.indexOf(incompleteTasks[index]));
            },
          ),
        );
      },
    );
  }

  void _showTaskDetailsDialog(BuildContext context, String taskName, String taskType, DateTime startDate, DateTime dueDate) {
    String formattedStartDate = DateFormat('dd/MM/yyyy').format(startDate);
    String formattedDueDate = DateFormat('dd/MM/yyyy').format(dueDate);

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Detalles de la Tarea'),
          content: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              Text('Nombre de la Tarea: $taskName'),
              Text('Tipo de Tarea: $taskType'),
              Text('Fecha de Inicio: $formattedStartDate'),
              Text('Fecha de Fin: $formattedDueDate'),
            ],
          ),
          actions: <Widget>[
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: Text('Cerrar'),
            ),
          ],
        );
      },
    );
  }
}
