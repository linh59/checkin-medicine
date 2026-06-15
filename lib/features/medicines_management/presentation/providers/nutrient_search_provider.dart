import 'package:checkin_medicine/features/medicines_management/presentation/providers/admin_medicine_repository_provider.dart';
import 'package:checkin_medicine/features/nutrient/data/models/nutrient_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

final nutrientSearchQueryProvider =
StateProvider.autoDispose<String>((ref) => '');

final nutrientSearchProvider =
FutureProvider.autoDispose<List<NutrientModel>>((ref) async {
  final keyword = ref.watch(nutrientSearchQueryProvider);

  return ref
      .read(adminMedicineRepositoryProvider)
      .searchNutrients(keyword);
});