import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/medicine_detail_model.dart';
import '../../data/repositories/medicine_repository.dart';


final medicineRepositoryProvider =
Provider(
      (ref) =>
      MedicineRepository(),
);

final medicineDetailProvider =
FutureProvider.family<
    MedicineDetailModel?,
    String>(
      (
      ref,
      slug,
      ) async {
    final repo = ref.read(
      medicineRepositoryProvider,
    );

    return repo.getMedicineDetail(
      slug,
    );
  },
);