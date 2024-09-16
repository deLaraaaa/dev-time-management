// lib/models/time_block.dart

class TimeBlock {
  String activityName;
  int duration; // Tempo atual da tarefa
  final int initialDuration; // Tempo original inserido pelo usuário
  bool isPaused;

  TimeBlock({required this.activityName, required this.duration})
      : initialDuration = duration, // Armazena o tempo inicial inserido pelo usuário
        isPaused = true;
}
