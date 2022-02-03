class TimeDifference {
  final DateTime dateTime;
  final now = DateTime.now();
  late final today = DateTime(now.year, now.month, now.day);
  late final firstDayOfWeek = now.subtract(Duration(days: now.weekday - 1));
  late final lastDayOfWeek =
      now.add(Duration(days: DateTime.daysPerWeek - now.weekday));
  late final thisMonth = DateTime(now.year, now.month);
  late final thisYear = DateTime(now.year);

  TimeDifference({required this.dateTime});

  bool isToday() {
    final currDate = DateTime(dateTime.year, dateTime.month, dateTime.day);
    if (currDate == today) {
      return true;
    } else {
      return false;
    }
  }

  bool isThisWeek() {
    final currDate = DateTime(dateTime.year, dateTime.month, dateTime.day);
    if ((currDate.difference(firstDayOfWeek).inDays < 0) || currDate.isAfter(lastDayOfWeek)) {
      return false;
    } else {
      return true;
    }
  }

  bool isThisMonth(){
      final currDate = DateTime(dateTime.year, dateTime.month);
    if (currDate == thisMonth) {
      return true;
    } else {
      return false;
    }
  }

    bool isThisYear(){
      final currDate = DateTime(dateTime.year);
    if (currDate == thisYear) {
      return true;
    } else {
      return false;
    }
  }
}
