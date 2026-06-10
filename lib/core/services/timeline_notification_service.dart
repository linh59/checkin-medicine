import 'package:checkin_medicine/core/services/notification_service.dart';
import 'package:checkin_medicine/core/utils/notification_time_utils.dart';
import 'package:checkin_medicine/features/timelines/data/models/timeline_slot_model.dart';
import 'package:checkin_medicine/l10n/app_localizations.dart';

class TimelineNotificationService {

  static Future<void> syncSlot({
    required String slotId,
    required bool notifyEnabled,
    required int notifyOffsetMin,
    required String time,
    required String medicineName,
    required double dose

}) async {

    /// 1. always cancel old notification
    await NotificationService.cancel(slotId.hashCode);

    /// 2. check enable
    if (!notifyEnabled) return;

    /// 3. compute time
    final notifyTime = NotificationTimeUtils.buildNotifyTime(
      time,
      notifyOffsetMin ?? 0,
    );

    /// 4. schedule new
    if (notifyTime.isAfter(DateTime.now())) {
      await NotificationService.scheduleNotification(
        id: slotId.hashCode,
        title: 'Đến giờ uống thuốc',
        body: '$time: $medicineName',
        dateTime: notifyTime,
      );
    }
  }
}