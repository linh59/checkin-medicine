import 'package:checkin_medicine/features/auth/presentation/providers/profile_provider.dart';
import 'package:checkin_medicine/features/home/presentation/providers/today_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final todayActionProvider = Provider((ref) => TodayActionController(ref));

class TodayActionController {
  final Ref ref;

  TodayActionController(this.ref);

  Future<void> markAsTaken({
    required String scheduleId,
    required String myMedicineId,
  }) async {
    final profileId = ref.read(profileProvider).profile?.id;

    if (profileId == null) return;

    await ref
        .read(todayRepositoryProvider)
        .markAsTaken(
          profileId: profileId,
          scheduleId: scheduleId,
          myMedicineId: myMedicineId,
        );

    ref.invalidate(todayTimelineProvider);
  }

  Future<void> undoTaken(String scheduleId) async {
    final profileId = ref.read(profileProvider).profile?.id;

    if (profileId == null) {
      return;
    }

    await ref
        .read(todayRepositoryProvider)
        .undoTaken(profileId: profileId, scheduleId: scheduleId);

    ref.invalidate(todayTimelineProvider);
  }
}
