import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

void showTaskDetailsDialog(BuildContext context, String taskName, String taskType, DateTime startDate, DateTime dueDate) {
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
