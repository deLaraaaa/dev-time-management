class TimeBlock {
  String activityName;
  int duration;
  final int initialDuration;
  bool isPaused;

  TimeBlock({required this.activityName, required this.duration})
      : initialDuration = duration,
        isPaused = true;
}
