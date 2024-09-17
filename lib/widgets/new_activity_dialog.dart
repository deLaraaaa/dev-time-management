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

  String? activityNameError;
  String? durationError;

  void _validateAndSave() {
    setState(() {
      activityNameError = activityName.isEmpty ? 'Nome da atividade não pode estar vazio' : null;
      durationError = duration <= 0 ? 'Informe um tempo válido (segundos)' : null;
    });

    if (activityNameError == null && durationError == null) {
      widget.onSave(TimeBlock(activityName: activityName, duration: duration));
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: const Text("Nova Atividade"),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextField(
            decoration: InputDecoration(
              labelText: 'Nome da Atividade',
              errorText: activityNameError,
            ),
            onChanged: (value) {
              setState(() {
                activityName = value;
              });
            },
          ),
          TextField(
            decoration: InputDecoration(
              labelText: 'Tempo (segundos)',
              errorText: durationError,
            ),
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
          onPressed: _validateAndSave,
          child: const Text("Salvar"),
        ),
      ],
    );
  }
}
