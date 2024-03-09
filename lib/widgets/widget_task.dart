import 'package:flutter/material.dart';

class TaskWidget extends StatelessWidget {
  final String taskName;
  final VoidCallback onDelete;
  final ValueChanged<bool?>? onCheckboxChanged;
  final bool isCompleted;
  final String taskType;
  final Function()? removeTask; // Nuevo parámetro para llamar al método removeTask

  TaskWidget({
    required this.taskName,
    required this.onDelete,
    required this.onCheckboxChanged,
    required this.isCompleted,
    required this.taskType,
    this.removeTask, // Actualización del constructor
  });

  @override
  Widget build(BuildContext context) {
    Color iconColor = Colors.transparent; // Color predeterminado del icono

    // Verificar el tipo de tarea y ajustar el color del icono en consecuencia
    if (taskType == 'Tarea') {
      iconColor = Colors.orange;
    } else if (taskType == 'Actividad calificable') {
      iconColor = Colors.red;
    }

    // Cambiar el color del icono a verde si la tarea está completada
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
                onCheckboxChanged!(!isCompleted); // Cambia el estado y llama a la función
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
          if (removeTask != null) {
            removeTask!(); // Llama al método removeTask si está definido
          }
          onDelete(); // Llama a la función onDelete
        },
      ),
    );
  }
}
