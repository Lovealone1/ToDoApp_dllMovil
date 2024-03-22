import 'package:flutter/material.dart';
import 'package:task_app/models/task_controller.dart';
import 'package:task_app/widgets/widget_task.dart';
import 'package:provider/provider.dart';
import 'package:task_app/widgets/widget_showtaskdialog.dart';

class AllTasksView extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Obtiene la instancia de TaskProvider
    final taskProvider = Provider.of<TaskProvider>(context);

    return taskProvider.tasks.isEmpty // Verifica si la lista de tareas está vacía
        ? Center(
            child: Text(
              'No hay tareas para mostrar :(\n¡Agrega una!',
              style: TextStyle(fontSize: 18.0),
              textAlign: TextAlign.center,
            ),
          )
        : ListView.builder(
            itemCount: taskProvider.tasks.length,
            itemBuilder: (context, index) {
              // Obtener el estado de completitud de la tarea
              bool isCompleted = taskProvider.tasks[index].completed;

              return GestureDetector(
                onTap: () {
                  showTaskDetailsDialog( // Llama a la función showTaskDetailsDialog
                    context,
                    taskProvider.tasks[index].taskName,
                    taskProvider.tasks[index].taskType,
                    taskProvider.tasks[index].startDate,
                    taskProvider.tasks[index].dueDate,
                  );
                },
                child: TaskWidget(
                  taskName: taskProvider.tasks[index].taskName,
                  taskType: taskProvider.tasks[index].taskType,
                  onDelete: () {
                    taskProvider.removeTask(index);
                  },
                  isCompleted: isCompleted,
                  onCheckboxChanged: (value) {
                    taskProvider.toggleTaskCompletion(index); // Cambia el estado de completitud de la tarea
                  },
                ),
              );
            },
          );
  }
}
