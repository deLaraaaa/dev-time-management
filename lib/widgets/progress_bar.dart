import 'package:flutter/material.dart';

class ProgressBar extends StatelessWidget {
  final int duration;
  final int initialDuration;

  const ProgressBar({
    super.key,
    required this.duration,
    required this.initialDuration,
  });

  @override
  Widget build(BuildContext context) {
    double progress = (initialDuration - duration) / initialDuration;
    int percentage = (progress * 100).toInt();
    return Row(
      children: [
        Container(
          margin: const EdgeInsets.only(right: 5),
          child: Text('$percentage%'),
        ),
        SizedBox(
          width: 50,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(5),
            child: LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.grey[300],
              color: const Color(0xFF3B234A),
            ),
          ),
        ),
      ],
    );
  }
}