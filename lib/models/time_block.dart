// lib/models/time_block.dart

class TimeBlock {
  final String activityName;
  int duration; // Duração em minutos
  bool isPaused;

  TimeBlock({required this.activityName, required this.duration, this.isPaused = true});
}
