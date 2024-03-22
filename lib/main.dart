import 'package:flutter/material.dart';
import 'package:task_app/views/alltasks_view.dart';
import 'package:task_app/views/activetasks_view.dart';
import 'package:task_app/views/completedtasks_view.dart'; // Importa la vista de tareas completadas
import 'package:task_app/widgets/widget_addtask.dart';
import 'package:task_app/models/task_controller.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TaskProvider(), // Inicializa TaskProvider
      child: MaterialApp(
        title: 'ToDo List App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: ToDoListScreen(),
      ),
    );
  }
}

class ToDoListScreen extends StatefulWidget {
  @override
  _ToDoListScreenState createState() => _ToDoListScreenState();
}

class _ToDoListScreenState extends State<ToDoListScreen> {
  late PageController pageController;
  int pageIndex = 0;

  @override
  void initState() {
    super.initState();
    pageController = PageController();
  }

  void _showAddTaskDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AddTaskDialog();
      },
    ).then((_) {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('ToDo APP'),
      ),
      body: PageView(
        controller: pageController,
        onPageChanged: (index) {
          setState(() {
            pageIndex = index;
          });
        },
        children: [
          AllTasksView(),
          ActiveTasksView(),
          CompletedTasks(),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddTaskDialog(context),
        tooltip: 'Agregar tarea',
        child: Icon(Icons.add),
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: pageIndex,
        onTap: (index) {
          setState(() {
            pageIndex = index;
            pageController.animateToPage(
              index,
              duration: Duration(milliseconds: 300),
              curve: Curves.easeInOut,
            );
          });
        },
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

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }
}