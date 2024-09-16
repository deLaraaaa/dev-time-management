// lib/widgets/new_activity_dialog.dart

import 'package:flutter/material.dart';
import 'package:dev_management_timer/models/time_block.dart';

class NewActivityDialog extends StatefulWidget {
  final Function(TimeBlock) onSave;

  NewActivityDialog({required this.onSave});

  @override
  _NewActivityDialogState createState() => _NewActivityDialogState();
}

class _NewActivityDialogState extends State<NewActivityDialog> {
  String activityName = '';
  int duration = 0;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text("Nova Atividade"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            decoration: InputDecoration(labelText: 'Nome da Atividade'),
            onChanged: (value) {
              setState(() {
                activityName = value;
              });
            },
          ),
          TextField(
            decoration: InputDecoration(labelText: 'Tempo (segundos)'),
            keyboardType: TextInputType.number,
            onChanged: (value) {
              setState(() {
                duration = int.tryParse(value) ?? 0;
              });
            },
          ),
        ],
      ),
      actions: [
        TextButton(
          child: Text("Cancelar"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        ElevatedButton(
          child: Text("Salvar"),
          onPressed: () {
            if (activityName.isNotEmpty && duration > 0) {
              widget.onSave(TimeBlock(activityName: activityName, duration: duration));
              Navigator.of(context).pop();
            }
          },
        ),
      ],
    );
  }
}
