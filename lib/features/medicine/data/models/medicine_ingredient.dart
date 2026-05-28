import '../../../nutrient/data/models/ingredient_form_model.dart';

class MedicineIngredient {
  final String id;
  final String? medicineId;
  final String? formId;

  final double amountPerPill;
  final String unit;
  final double? percentDv;
  final IngredientForm?
  ingredientForm;

  MedicineIngredient({
    required this.id,
    required this.medicineId,
    required this.formId,
    required this.amountPerPill,
    required this.unit,
    required this.percentDv,
    required this.ingredientForm,
  });

  factory MedicineIngredient
      .fromJson(
      Map<String, dynamic> json,
      ) {
    return MedicineIngredient(
      id:
      json['id']
          .toString(),

      medicineId:
      json['medicine_id']
          ?.toString(),

      formId:
      json['form_id']
          ?.toString(),

      amountPerPill:
      double.tryParse(
        json[
        'amount_per_pill']
            ?.toString() ??
            '',
      ) ??
          0,

      unit:
      json['unit'] ?? '',

      percentDv:
      double.tryParse(
        json['percent_dv']
            ?.toString() ??
            '',
      ),

      /// IMPORTANT
      ingredientForm:
      json['ingredient_forms'] !=
          null
          ? IngredientForm
          .fromJson(
        json[
        'ingredient_forms'
        ],
      )
          : null,
    );
  }
}