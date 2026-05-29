import 'package:checkin_medicine/features/auth/presentation/providers/profile_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/my_medicine_model.dart';
import '../../data/repositories/my_medicine_repository.dart';

final myMedicineRepositoryProvider = Provider<MyMedicineRepository>(
  (ref) => MyMedicineRepository(),
);

final myMedicinesProvider = FutureProvider<List<MyMedicineModel>>((ref) async {
  final profileState = ref.watch(profileProvider);

  final profileId = profileState.profile?.id;

  if (profileId == null) {
    return [];
  }

  return ref.read(myMedicineRepositoryProvider).getMyMedicines(profileId);
});

final addMyMedicineProvider =
    AsyncNotifierProvider<AddMyMedicineNotifier, void>(
      AddMyMedicineNotifier.new,
    );

class AddMyMedicineNotifier extends AsyncNotifier<void> {
  @override
  Future<void> build() async {}

  Future<void> add({
    required String profileId,
    required String medicineId,
    String? nickname,
    String? notes,
  }) async {
    final repo = ref.read(myMedicineRepositoryProvider);

    state = const AsyncLoading();

    try {
      await repo.addMedicine(
        profileId: profileId,
        medicineId: medicineId,
        nickname: nickname,
        notes: notes,
      );

      // reload list
      ref.invalidate(myMedicinesProvider);

      state = const AsyncData(null);
    } catch (e, st) {
      state = AsyncError(e, st);
      rethrow;
    }
  }
}
