import 'package:checkin_medicine/features/medicines_management/data/repositories/admin_medicine_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final adminMedicineRepositoryProvider = Provider<AdminMedicineRepository>((
  ref,
) {
  return AdminMedicineRepository();
});
