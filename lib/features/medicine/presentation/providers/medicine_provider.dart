import 'package:checkin_medicine/features/medicine/data/models/medicine_detail_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../../data/repositories/medicine_repository.dart';


final medicineRepositoryProvider =
Provider<MedicineRepository>((ref) {
  return MedicineRepository(
    Supabase.instance.client,
  );
});

final medicineDetailProvider =
FutureProvider.family<Medicine?, String>(
      (ref, slug) async {
    final repo = ref.watch(
      medicineRepositoryProvider,
    );

    return repo.getMedicineBySlug(slug);
  },
);