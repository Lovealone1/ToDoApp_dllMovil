import 'package:flutter/material.dart';

class TaskWidget extends StatelessWidget {
  final String taskName;
  final VoidCallback onDelete;
  final ValueChanged<bool?>? onCheckboxChanged;
  final bool isCompleted;
  final String taskType;

  TaskWidget({
    required this.taskName,
    required this.onDelete,
    required this.onCheckboxChanged,
    required this.isCompleted,
    required this.taskType,
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

    return ListTile(
      title: Row(
        children: [
          Expanded(
            child: Text(
              taskName,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
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
        onPressed: onDelete,
      ),
    );
  }
}
