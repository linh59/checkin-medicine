import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../auth/presentation/providers/profile_provider.dart';
import 'today_provider.dart';
import '../../data/repositories/today_repository.dart';

final todayRepositoryProvider = Provider<TodayRepository>(
  (ref) => TodayRepository(),
);

final todayActionProvider = AsyncNotifierProvider<TodayActionNotifier, void>(
  TodayActionNotifier.new,
);

class TodayActionNotifier extends AsyncNotifier<void> {
  @override
  Future<void> build() async {}

  Future<void> markAsTaken({
    required String scheduleId,
    required String myMedicineId,
  }) async {
    final repo = ref.read(todayRepositoryProvider);
    final profileId = ref.read(profileProvider).profile!.id;

    await repo.markAsTaken(
      profileId: profileId,
      scheduleId: scheduleId,
      myMedicineId: myMedicineId,
    );

    // 🔥 FORCE UI UPDATE
    ref.invalidate(todayTimelineProvider);
  }

  Future<void> undoTaken({required String scheduleId}) async {
    final repo = ref.read(todayRepositoryProvider);
    final profileId = ref.read(profileProvider).profile!.id;

    await repo.undoTaken(profileId: profileId, scheduleId: scheduleId);

    // 🔥 FORCE UI UPDATE
    ref.invalidate(todayTimelineProvider);
  }
}
