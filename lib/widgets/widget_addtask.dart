import 'package:flutter/material.dart';

import 'package:task_app/models/task_controller.dart';

class AddTaskDialog extends StatefulWidget {
  final TaskController taskController;

  AddTaskDialog({required this.taskController});

  @override
  _AddTaskDialogState createState() => _AddTaskDialogState();
}

class _AddTaskDialogState extends State<AddTaskDialog> {
  late TextEditingController _taskNameController;
  late TextEditingController _descriptionController;
  late DateTime _startDate;
  late DateTime _dueDate;
  late String _selectedTaskType;
  final List<String> _taskTypes = ['Seleccione una opción', 'Tarea', 'Actividad calificable'];

  @override
  void initState() {
    super.initState();
    _taskNameController = TextEditingController();
    _descriptionController = TextEditingController();
    _startDate = DateTime.now();
    _dueDate = DateTime.now();
    _selectedTaskType = _taskTypes[0]; // Default to 'Seleccione una opción'
  }

  @override
  void dispose() {
    _taskNameController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: isStartDate ? _startDate : _dueDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2100),
    );
    if (pickedDate != null && pickedDate != (isStartDate ? _startDate : _dueDate)) {
      setState(() {
        if (isStartDate) {
          _startDate = pickedDate;
        } else {
          _dueDate = pickedDate;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Add Task'),
      content: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: _taskNameController,
              decoration: InputDecoration(labelText: 'Nombre de la tarea'),
            ),
            TextField(
              controller: _descriptionController,
              decoration: InputDecoration(labelText: 'Descripción'),
            ),
            Row(
              children: [
                Text('Fecha de inicio: '),
                TextButton(
                  onPressed: () => _selectDate(context, true),
                  child: Text('${_startDate.day}/${_startDate.month}/${_startDate.year}'),
                ),
              ],
            ),
            Row(
              children: [
                Text('Fecha de entrega: '),
                TextButton(
                  onPressed: () => _selectDate(context, false),
                  child: Text('${_dueDate.day}/${_dueDate.month}/${_dueDate.year}'),
                ),
              ],
            ),
            DropdownButton<String>(
              value: _selectedTaskType,
              onChanged: (String? newValue) {
                setState(() {
                  _selectedTaskType = newValue!;
                });
              },
              items: _taskTypes.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ],
        ),
      ),
      actions: <Widget>[
        TextButton(
          onPressed: () {
            Navigator.of(context).pop(); // Close dialog on cancel
          },
          child: Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _selectedTaskType == _taskTypes[0]
              ? null
              : () {
                  if (_selectedTaskType == 'Seleccione una opción') {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Por favor, seleccione un tipo de tarea válido.'),
                      ),
                    );
                  } else {
                    Task newTask = Task(
                      taskName: _taskNameController.text,
                      description: _descriptionController.text,
                      startDate: _startDate,
                      dueDate: _dueDate,
                      taskType: _selectedTaskType,
                    );
                    widget.taskController.addTask(newTask);
                    Navigator.of(context).pop(); // Close dialog on submit
                  }
                },
          child: Text('Add'),
        ),
      ],
    );
  }
}
