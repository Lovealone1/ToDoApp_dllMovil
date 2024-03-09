import 'package:flutter/material.dart';
import 'package:task_app/widgets/widget_task.dart';
import 'package:task_app/widgets/widget_addtask.dart';
import 'package:task_app/models/task_controller.dart';
import 'package:intl/intl.dart';
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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Tareas'),
      ),
      body: ListView.builder(
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
              taskType: taskController.tasks[index].taskType, // Agregar el tipo de tarea
              onDelete: () {
                setState(() {
                  taskController.removeTask(index);
                });
              },
              isCompleted: isCompleted,
              onCheckboxChanged: (value) {
                // Cambiar el estado de completitud de la tarea
                setState(() {
                  taskController.toggleTask(index);
                });
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddTaskDialog(context),
        tooltip: 'Agregar tarea',
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Icon(Icons.list),
            label: 'All',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.all_out),
            label: 'Active',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.checklist),
            label: 'Completed',
          ),
        ],
      ),
    );
  }
}
