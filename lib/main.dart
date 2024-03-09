import 'package:flutter/material.dart';
import 'package:task_app/widgets/widget_task.dart';
import 'package:task_app/widgets/widget_addtask.dart';
import 'package:task_app/models/task_controller.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ToDo List App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: ToDoListScreen(),
    );
  }
}

class ToDoListScreen extends StatefulWidget {
  @override
  _ToDoListScreenState createState() => _ToDoListScreenState();
}

class _ToDoListScreenState extends State<ToDoListScreen> {
  late TaskController taskController; // Definición de taskController

  @override
  void initState() {
    super.initState();
    taskController = TaskController(); // Inicialización de taskController
  }

  void _showAddTaskDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AddTaskDialog(taskController: taskController);
      },
    ).then((_) {
      // Actualizar el estado después de agregar una tarea
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Tareas'),
      ),
      body: ListView.builder(
        itemCount: taskController.tasks.length,
        itemBuilder: (context, index) {
          return TaskWidget(
            taskName: taskController.tasks[index].taskName,
            onDelete: () {
              setState(() {
                taskController.removeTask(index);
              });
            },
            onCheckboxChanged: (value) {
              // Implementa la lógica para el cambio de estado del checkbox aquí
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddTaskDialog(context),
        tooltip: 'Agregar tarea',
        child: Icon(Icons.add),
      ),
    );
  }
}
