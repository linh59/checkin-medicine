import '../../../nutrient/data/models/ingredient_form_model.dart';
import '../../../nutrient/data/models/nutrient_model.dart';

class MedicineIngredient {
  final String id;
  final String? medicineId;
  final String? nutrientId;

  final double? amountPerServing;
  final String unit;
  final double? percentDv;

  final NutrientModel? nutrient;

  final List<IngredientForm> forms;

  const MedicineIngredient({
    required this.id,
    required this.medicineId,
    required this.nutrientId,
    required this.amountPerServing,
    required this.unit,
    required this.percentDv,
    required this.nutrient,
    required this.forms,
  });

  factory MedicineIngredient.fromJson(Map<String, dynamic> json) {
    final formList =
    (json['medicine_ingredient_forms'] as List<dynamic>? ?? []);

    return MedicineIngredient(
      id: json['id']?.toString() ?? '',

      medicineId: json['medicine_id']?.toString(),

      nutrientId: json['nutrient_id']?.toString(),

      amountPerServing: double.tryParse(
        json['amount_per_serving']?.toString() ?? '',
      ) ??
          0,

      unit: json['unit']?.toString() ?? '',

      percentDv: double.tryParse(
        json['percent_dv']?.toString() ?? '',
      ),

      nutrient: json['nutrients'] == null
          ? null
          : NutrientModel.fromJson(
        json['nutrients'],
      ),

      forms: formList
          .where(
            (e) => e['ingredient_forms'] != null,
      )
          .map<IngredientForm>(
            (e) => IngredientForm.fromJson(
          e['ingredient_forms'],
        ),
      )
          .toList(),
    );
  }
}