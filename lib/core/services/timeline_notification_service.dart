import 'package:checkin_medicine/core/services/notification_service.dart';
import 'package:checkin_medicine/core/utils/notification_time_utils.dart';

class TimelineNotificationService {
  static Future<void> syncSlot({
    required String slotId,
    required bool notifyEnabled,
    required int notifyOffsetMin,
    required String time,
    required String medicineName,
    required double dose,
  }) async {
    final notificationId = slotId.hashCode;

    /// Luôn huỷ notification cũ
    await NotificationService.cancel(notificationId);

    /// Nếu user tắt nhắc thuốc thì dừng
    if (!notifyEnabled) return;

    /// Tính thời gian nhắc
    final notifyTime = NotificationTimeUtils.buildNotifyTime(
      time,
      notifyOffsetMin,
    );

    /// Schedule notification lặp hằng ngày
    await NotificationService.scheduleNotification(
      id: notificationId,
      title: 'Đến giờ uống thuốc',
      body: '$time • $dose viên $medicineName',
      dateTime: notifyTime,
    );
  }
}