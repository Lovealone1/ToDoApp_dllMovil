import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:task_app/models/task_controller.dart';
import 'package:task_app/widgets/widget_task.dart';

class AllTasksView extends StatelessWidget {
  final TaskController taskController;
  final Function(int) toggleTaskCompletion;

  const AllTasksView({
    Key? key,
    required this.taskController,
    required this.toggleTaskCompletion,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return taskController.tasks.isEmpty // Verificar si la lista de tareas está vacía
        ? Center(
            child: Text(
              'No hay tareas para mostrar :(\n¡Agrega una!',
              style: TextStyle(fontSize: 18.0),
              textAlign: TextAlign.center,
            ),
          )
        : ListView.builder(
            itemCount: taskController.tasks.length,
            itemBuilder: (context, index) {
              // Obtener el estado de completitud de la tarea
              bool isCompleted = taskController.tasks[index].completed;

              return GestureDetector(
                onTap: () {
                  _showTaskDetailsDialog(
                    context,
                    taskController.tasks[index].taskName,
                    taskController.tasks[index].taskType,
                    taskController.tasks[index].startDate,
                    taskController.tasks[index].dueDate,
                  );
                },
                child: TaskWidget(
                  taskName: taskController.tasks[index].taskName,
                  taskType: taskController.tasks[index].taskType,
                  onDelete: () {
                    taskController.removeTask(index);
                  },
                  isCompleted: isCompleted,
                  onCheckboxChanged: (value) {
                    toggleTaskCompletion(index); // Cambia el estado de completitud de la tarea
                  },
                ),
              );
            },
          );
  }

  // Esta es la función para mostrar los detalles de la tarea
  void _showTaskDetailsDialog(BuildContext context, String taskName, String taskType, DateTime startDate, DateTime dueDate) {
    // Formatear las fechas en el formato deseado
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
