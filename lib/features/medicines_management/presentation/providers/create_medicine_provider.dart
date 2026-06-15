import 'package:checkin_medicine/features/medicines_management/data/models/medicine_form.dart';
import 'package:checkin_medicine/features/medicines_management/data/repositories/admin_medicine_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import 'admin_medicine_repository_provider.dart';

final createMedicineProvider =
    StateNotifierProvider<CreateMedicineNotifier, AsyncValue<String?>>((ref) {
      return CreateMedicineNotifier(ref.read(adminMedicineRepositoryProvider));
    });

class CreateMedicineNotifier extends StateNotifier<AsyncValue<String?>> {
  CreateMedicineNotifier(this._repository) : super(const AsyncData(null));

  final AdminMedicineRepository _repository;

  Future<void> createMedicine(MedicineForm model) async {
    state = const AsyncLoading();

    state = await AsyncValue.guard(() async {
      return await _repository.createMedicine(model);
    });
  }

  void reset() {
    state = const AsyncData(null);
  }
}
