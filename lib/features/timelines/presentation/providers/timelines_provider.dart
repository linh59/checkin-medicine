import 'package:checkin_medicine/features/timelines/data/models/timeline_detail_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../auth/presentation/providers/profile_provider.dart';
import '../../data/models/plan_model.dart';
import '../../data/repositories/timeline_repository.dart';

final timelineRepositoryProvider = Provider<TimelineRepository>((ref) {
  return TimelineRepository();
});

final plansProvider = AsyncNotifierProvider<PlansNotifier, List<PlanModel>>(
  PlansNotifier.new,
);

class PlansNotifier extends AsyncNotifier<List<PlanModel>> {
  TimelineRepository get repo => ref.read(timelineRepositoryProvider);

  @override
  Future<List<PlanModel>> build() async {
    final profileState = ref.watch(profileProvider);
    final profileId = profileState.profile?.id;

    if (profileId == null) {
      return [];
    }

    return repo.getPlans(profileId);
  }

  Future<void> refresh() async {
    state = const AsyncLoading();

    final profileState = ref.read(profileProvider);
    final profileId = profileState.profile?.id;

    if (profileId == null) {
      state = const AsyncValue.data([]);
      return;
    }

    try {
      final plans = await repo.getPlans(profileId);

      state = AsyncValue.data(plans);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<String> createPlan({required String name}) async {
    final profileState = ref.read(profileProvider);
    final profileId = profileState.profile?.id;

    if (profileId == null) {
      throw Exception('Profile not found');
    }

    final planId = await repo.createPlan(profileId: profileId, name: name);

    await refresh();

    return planId;
  }

  Future<void> togglePlan(String id, bool value) async {
    final current = state.value ?? [];

    state = AsyncValue.data(
      current.map((p) {
        if (p.id == id) {
          return PlanModel(
            id: p.id,
            profileId: p.profileId,
            name: p.name,
            notes: p.notes,
            isActive: value,
            mode: p.mode,
            color: p.color,
            createdAt: p.createdAt,
            itemCount: p.itemCount,
            archived: p.archived,
          );
        }

        return p;
      }).toList(),
    );

    try {
      await repo.togglePlan(id, value);
    } catch (e, st) {
      state = AsyncValue.error(e, st);

      await refresh();
    }
  }

  Future<void> addToPlan({
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

  // Future<void> deletePlan(String planId) async {
  //   await repo.deletePlan(planId);

  //   await refresh();
  // }

  Future<void> activatePlan(String planId) async {
    await repo.togglePlan(planId, true);

    await refresh();
  }

  Future<void> deactivatePlan(String planId) async {
    await repo.togglePlan(planId, false);

    await refresh();
  }

  Future<void> updatePlanItem({
    required String slotId,
    required String planItemId,
    required double dose,
    required String time,
    String? withFood,
  }) async {
    await repo.updatePlanItem(
      slotId: slotId,
      planItemId: planItemId,
      dose: dose,
      time: time,
      withFood: withFood,
    );
  }

  Future<void> deletePlanItem(String slotId) async {
    await repo.deletePlanItem(slotId);
  }

  Future<void> updatePlanItemNotify({
    required String slotId,
    required bool notifyEnabled,
    required int offsetMin
  }) async {
    await repo.toggleNotify(
     slotId, notifyEnabled, offsetMin
    );
  }
}

final timelineDetailProvider =
    FutureProvider.family<TimelineDetailModel, String>((ref, id) async {
      return ref.read(timelineRepositoryProvider).getTimelineDetail(id);
    });
