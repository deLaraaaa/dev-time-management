import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:dev_management_timer/models/time_block.dart';

class NewActivityDialog extends StatefulWidget {
  final Function(TimeBlock) onSave;

  const NewActivityDialog({super.key, required this.onSave});

  @override
  NewActivityDialogState createState() => NewActivityDialogState();
}

class NewActivityDialogState extends State<NewActivityDialog> {
  String activityName = '';
  int duration = 0;

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Nova Atividade"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            decoration: const InputDecoration(labelText: 'Nome da Atividade'),
            onChanged: (value) {
              setState(() {
                activityName = value;
              });
            },
          ),
          TextField(
            decoration: const InputDecoration(labelText: 'Tempo (segundos)'),
            keyboardType: TextInputType.number,
            inputFormatters: <TextInputFormatter>[
              FilteringTextInputFormatter.digitsOnly,
            ],
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
          child: const Text("Cancelar"),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        ElevatedButton(
          child: const Text("Salvar"),
          onPressed: () {
            if (activityName.isNotEmpty && duration > 0) {
              widget.onSave(
                  TimeBlock(activityName: activityName, duration: duration));
              Navigator.of(context).pop();
            }
          },
        ),
      ],
    );
  }
}
