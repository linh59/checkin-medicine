import 'package:checkin_medicine/core/services/medicine_ai_service.dart';
import 'package:checkin_medicine/features/search/data/repositories/search_ai_medicine_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final medicineAiServiceProvider = Provider((ref) {
  return MedicineAiService();
});

final medicineAIProvider = FutureProvider.family((ref, String query) async {
  final repo = ref.read(medicineAiServiceProvider);
  return repo.searchMedicine(query);
});
