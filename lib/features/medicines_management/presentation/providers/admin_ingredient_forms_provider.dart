import 'package:checkin_medicine/features/medicines_management/presentation/providers/admin_medicine_repository_provider.dart';
import 'package:checkin_medicine/features/nutrient/data/models/ingredient_form_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final adminIngredientFormsProvider =
    FutureProvider.family<List<IngredientForm>, String>((
      ref,
      nutrientId,
    ) async {
      return  ref.read(adminMedicineRepositoryProvider).getFormsByNutrient(nutrientId);


    });
