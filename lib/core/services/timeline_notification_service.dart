import 'package:checkin_medicine/core/services/notification_service.dart';
import 'package:checkin_medicine/core/utils/notification_time_utils.dart';
import 'package:checkin_medicine/features/timelines/data/repositories/timeline_repository.dart';

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
  static Future<void> syncAll(String profileId) async {
    // Xoá toàn bộ notification cũ
    await NotificationService.cancelAll();
    final repo = TimelineRepository();

    final slots = await repo.getAllNotifySlots(profileId);

    for (final slot in slots) {
      await syncSlot(
        slotId: slot.slotId,
        notifyEnabled: slot.notifyEnabled,
        notifyOffsetMin: slot.notifyOffsetMin,
        time: slot.time,
        medicineName: slot.medicineName,
        dose: slot.dose,
      );
    }
  }
  static Future<void> cancelSlot(String slotId) async {
    await NotificationService.cancel(slotId.hashCode);
  }
}