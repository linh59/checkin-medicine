import 'package:checkin_medicine/features/nutrient/data/models/nutrient_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/medicine_model.dart';
import '../../data/repositories/search_repository.dart';

final searchRepositoryProvider = Provider((ref) => SearchRepository());

final medicineSearchProvider =
    FutureProvider.family<List<MedicineModel>, String>((ref, query) async {
      return ref.read(searchRepositoryProvider).searchMedicines(query);
    });

final nutrientSearchProvider =
    FutureProvider.family<List<NutrientModel>, String>((ref, query) async {
      return ref.read(searchRepositoryProvider).searchNutrients(query);
    });
