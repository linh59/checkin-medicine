class NotificationTimeUtils {
  static DateTime buildNotifyTime(
      String time,
      int offsetMin,
      ) {
    final parts = time.split(':');

    final now = DateTime.now();

    final medicineTime = DateTime(
      now.year,
      now.month,
      now.day,
      int.parse(parts[0]),
      int.parse(parts[1]),
    );

    return medicineTime.subtract(
      Duration(minutes: offsetMin),
    );
  }
}