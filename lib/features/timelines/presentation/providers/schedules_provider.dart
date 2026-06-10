import 'package:checkin_medicine/core/services/timeline_notification_service.dart';
import 'package:checkin_medicine/features/timelines/data/models/timeline_slot_model.dart';
import 'package:checkin_medicine/features/timelines/data/repositories/timeline_repository.dart';
import 'package:checkin_medicine/features/timelines/presentation/providers/timelines_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';


final schedulesProvider =
AsyncNotifierProvider<Schedule, void>(Schedule.new);

class Schedule extends AsyncNotifier<void> {
  TimelineRepository get repo => ref.read(timelineRepositoryProvider);

  @override
  Future<void> build() async {}

  Future<void> addScheduleToPlan({
    required String planId,
    required String myMedicineId,
    required double dose,
    required String time,
    String? withFood,
  }) async {
    await repo.addToPlan(
      planId: planId,
      myMedicineId: myMedicineId,
      dose: dose,
      time: time,
      withFood: withFood,
    );
  }

  Future<void> updateNotify({
    required TimelineSlotModel slot,
    required bool enabled,
    required int offsetMin,

  }) async {
    state = const AsyncLoading();

    try {
      await repo.toggleNotify(slot.slotId, enabled, offsetMin);

      await TimelineNotificationService.syncSlot(
          slotId: slot.slotId,
          notifyEnabled: enabled,
          notifyOffsetMin: offsetMin,
          time: slot.time,
          medicineName: slot.medicineName,
          dose: slot.dose
      );


      state = const AsyncData(null);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }

  Future<void> updateScheduleOfPlan({
    required TimelineSlotModel slot,
    required String planItemId,
    required double dose,
    required String time,
    String? withFood,
  }) async {
    state = const AsyncLoading();

    try {
      await repo.updatePlanItem(
        slotId: slot.slotId,
        planItemId: planItemId,
        dose: dose,
        time: time,
        withFood: withFood,
      );

      await TimelineNotificationService.syncSlot(
        slotId: slot.slotId,
        notifyEnabled: slot.notifyEnabled,
        notifyOffsetMin: slot.notifyOffsetMin,
        time: time,
        medicineName: slot.medicineName,
        dose: dose
      );

      state = const AsyncData(null);
    } catch (e, st) {
      state = AsyncError(e, st);
    }
  }
  Future<void> deleteScheduleOfPlan(String slotId) async {
    await repo.deletePlanItem(slotId);
  }

}