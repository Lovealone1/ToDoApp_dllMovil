import 'package:flutter/material.dart';
import 'package:task_app/widgets/widget_task.dart';


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
  List<String> tasks = ['Task 1', 'Task 2', 'Task 3'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Tareas'),
      ),
      body: ListView.builder(
        itemCount: tasks.length,
        itemBuilder: (context, index) {
          return TaskWidget(
            taskName: tasks[index],
            onDelete: () {
              setState(() {
                tasks.removeAt(index);
              });
            },
            onCheckboxChanged: (value) {
              // Implementa la lógica para el cambio de estado del checkbox aquí
            },
          );
        },
      ),
    );
  }
}
