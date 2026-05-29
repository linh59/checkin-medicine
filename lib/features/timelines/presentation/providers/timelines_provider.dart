import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../auth/presentation/providers/profile_provider.dart';
import '../../data/models/plan_model.dart';
import '../../data/repositories/timeline_repository.dart';

final timelineRepositoryProvider = Provider((ref) {
  return TimelineRepository();
});

final plansProvider = AsyncNotifierProvider<PlansNotifier, List<PlanModel>>(
  PlansNotifier.new,
);

class PlansNotifier extends AsyncNotifier<List<PlanModel>> {
  late TimelineRepository repo;

  @override
  Future<List<PlanModel>> build() async {
    repo = ref.read(timelineRepositoryProvider);

    // 🔥 reactive giống My Medicines
    final profileState = ref.watch(profileProvider);
    final profileId = profileState.profile?.id;

    if (profileId == null) return [];

    return repo.getPlans(profileId);
  }

  /// 🔥 OPTIMISTIC TOGGLE (no flicker)
  Future<void> togglePlan(String id, bool value) async {
    final current = state.value ?? [];

    // optimistic update
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
          );
        }
        return p;
      }).toList(),
    );

    try {
      await repo.togglePlan(id, value);
    } catch (e, st) {
      // rollback if fail
      state = AsyncValue.error(e, st);
    }
  }

  /// manual refresh (optional)
  Future<void> refresh() async {
    state = const AsyncLoading();
    state = AsyncValue.data(await build());
  }
}
