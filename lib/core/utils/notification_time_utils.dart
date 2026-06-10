class NotificationTimeUtils {
  static DateTime buildNotifyTime(
      String time,
      int offsetMin,
      ) {
    final now = DateTime.now();

    final parts = time.split(':');
    final hour = int.parse(parts[0]);
    final minute = int.parse(parts[1]);

    final scheduled = DateTime(
      now.year,
      now.month,
      now.day,
      hour,
      minute,
    );

    return scheduled.subtract(Duration(minutes: offsetMin));
  }
}