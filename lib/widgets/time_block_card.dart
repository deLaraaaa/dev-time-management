import 'package:flutter/material.dart';
import 'package:dev_management_timer/models/time_block.dart';
import 'dart:async';

class TimeBlockCard extends StatefulWidget {
  final TimeBlock timeBlock;
  final VoidCallback onTimeComplete;
  final VoidCallback onDelete;

  const TimeBlockCard({
    super.key,
    required this.timeBlock,
    required this.onTimeComplete,
    required this.onDelete,
  });

  @override
  TimeBlockCardState createState() => TimeBlockCardState();
}

class TimeBlockCardState extends State<TimeBlockCard> {
  Timer? timer;

  void startTimer() {
    if (timer != null) {
      return;
    }
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
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
      color: const Color(0xFFc3bbc9),
      child: ListTile(
        title: Text(widget.timeBlock.activityName),
        subtitle: Text('Tempo restante: ${widget.timeBlock.duration} segundos'),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            IconButton(
              icon: Icon(
                  widget.timeBlock.isPaused ? Icons.play_arrow : Icons.pause,
                  color: const Color(0xFF3B234A)),
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
              icon: const Icon(Icons.refresh, color: Color(0xFF3B234A)),
              onPressed: () {
                setState(() {
                  widget.timeBlock.duration = widget.timeBlock.initialDuration;
                });
              },
            ),
            IconButton(
              icon: const Icon(Icons.delete, color: Color(0xFF3B234A)),
              onPressed: () {
                setState(() {
                  widget.timeBlock.isPaused = !widget.timeBlock.isPaused;
                  if (widget.timeBlock.isPaused) {
                    pauseTimer();
                  }
                });
                widget.onDelete();
              },
            ),
          ],
        ),
      ),
    );
  }
}
