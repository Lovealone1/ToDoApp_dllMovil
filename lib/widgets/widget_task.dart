import 'package:flutter/material.dart';

class TaskWidget extends StatelessWidget {
  final String taskName;
  final VoidCallback onDelete;
  final ValueChanged<bool?>? onCheckboxChanged;

  TaskWidget({
    required this.taskName,
    required this.onDelete,
    required this.onCheckboxChanged,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(taskName),
      leading: Checkbox(
        value: false, // Estado inicial del checkbox
        onChanged: onCheckboxChanged,
      ),
      trailing: IconButton(
        icon: Icon(Icons.delete),
        onPressed: onDelete,
      ),
    );
  }
}
