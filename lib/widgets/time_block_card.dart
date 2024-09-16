// lib/widgets/time_block_card.dart

import 'package:flutter/material.dart';
import 'package:dev_management_timer/models/time_block.dart';
import 'dart:async';

class TimeBlockCard extends StatefulWidget {
  final TimeBlock timeBlock;
  final VoidCallback onTimeComplete;

  TimeBlockCard({required this.timeBlock, required this.onTimeComplete});

  @override
  _TimeBlockCardState createState() => _TimeBlockCardState();
}

class _TimeBlockCardState extends State<TimeBlockCard> {
  Timer? timer;

  void startTimer() {
    if (timer != null) {
      return;
    }
    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (widget.timeBlock.duration > 0) {
          widget.timeBlock.duration--;
        } else {
          timer.cancel();
          widget.onTimeComplete();
        }
      });
    });
  }

  void pauseTimer() {
    timer?.cancel();
    timer = null;
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(widget.timeBlock.activityName),
        subtitle: Text('Tempo restante: ${widget.timeBlock.duration} segundos'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(widget.timeBlock.isPaused ? Icons.play_arrow : Icons.pause),
              onPressed: () {
                setState(() {
                  widget.timeBlock.isPaused = !widget.timeBlock.isPaused;
                  if (widget.timeBlock.isPaused) {
                    pauseTimer();
                  } else {
                    startTimer();
                  }
                });
              },
            ),
            IconButton(
              icon: const Icon(Icons.refresh),
              onPressed: () {
                setState(() {
                  widget.timeBlock.duration = widget.timeBlock.duration; // Reseta para o tempo original
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}
