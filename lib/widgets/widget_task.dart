import 'package:flutter/material.dart';

class TaskWidget extends StatelessWidget {
  final String taskName;
  final VoidCallback onDelete;
  final ValueChanged<bool?>? onCheckboxChanged;
  final bool isCompleted;
  final String taskType;
  final Function()? removeTask;

  TaskWidget({
    required this.taskName,
    required this.onDelete,
    required this.onCheckboxChanged,
    required this.isCompleted,
    required this.taskType,
    this.removeTask,
  });

  @override
  Widget build(BuildContext context) {
    Color iconColor = Colors.transparent;

    if (taskType == 'Tarea') {
      iconColor = Colors.orange;
    } else if (taskType == 'Actividad calificable') {
      iconColor = Colors.red;
    }

    if (isCompleted) {
      iconColor = Colors.green;
    }

    return ListTile(
      title: Row(
        children: [
          Expanded(
            child: Text(
              taskName,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              style: TextStyle(
                decoration: isCompleted ? TextDecoration.lineThrough : TextDecoration.none,
              ),
            ),
          ),
          GestureDetector(
            onTap: () {
              if (!isCompleted && onCheckboxChanged != null) {
                onCheckboxChanged!(!isCompleted);
              }
            },
            child: Icon(
              Icons.circle,
              size: 12,
              color: iconColor,
            ),
          ),
        ],
      ),
      leading: Checkbox(
        value: isCompleted,
        onChanged: onCheckboxChanged,
      ),
      trailing: IconButton(
        icon: Icon(Icons.delete_outline_rounded),
        onPressed: () {
          // Mostrar el cuadro de diálogo de confirmación
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text('Confirmar eliminación'),
                content: Text('¿Estás seguro de que quieres eliminar esta tarea?'),
                actions: <Widget>[
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Cerrar el cuadro de diálogo sin eliminar la tarea
                    },
                    child: Text('Cancelar'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop(); // Cerrar el cuadro de diálogo antes de eliminar la tarea
                      if (removeTask != null) {
                        removeTask!(); // Llama al método removeTask si está definido
                      }
                      onDelete(); // Llama a la función onDelete
                    },
                    child: Text('Eliminar'),
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}
