class MedicineIngredientInput {
  /// medicine_ingredients.nutrient_id
  final String nutrientId;

  /// medicine_ingredient_forms.form_id
  final List<String> formIds;

  /// medicine_ingredients.amount_per_serving
  final double amountPerServing;

  /// medicine_ingredients.unit
  final String unit;

  /// medicine_ingredients.percent_dv
  final double? percentDv;

  const MedicineIngredientInput({
    required this.nutrientId,
    this.formIds = const [],
    required this.amountPerServing,
    required this.unit,
    this.percentDv,
  });

  factory MedicineIngredientInput.fromJson(Map<String, dynamic> json) {
    return MedicineIngredientInput(
      nutrientId: json['nutrient_id']?.toString() ?? '',
      formIds: (json['form_ids'] as List?)
          ?.map((e) => e.toString())
          .toList() ??
          const [],
      amountPerServing:
      (json['amount_per_serving'] as num?)?.toDouble() ?? 0,
      unit: json['unit']?.toString() ?? 'mg',
      percentDv: (json['percent_dv'] as num?)?.toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'nutrient_id': nutrientId,
      'form_ids': formIds,
      'amount_per_serving': amountPerServing,
      'unit': unit,
      'percent_dv': percentDv,
    };
  }

  MedicineIngredientInput copyWith({
    String? nutrientId,
    List<String>? formIds,
    double? amountPerServing,
    String? unit,
    double? percentDv,
  }) {
    return MedicineIngredientInput(
      nutrientId: nutrientId ?? this.nutrientId,
      formIds: formIds ?? this.formIds,
      amountPerServing: amountPerServing ?? this.amountPerServing,
      unit: unit ?? this.unit,
      percentDv: percentDv ?? this.percentDv,
    );
  }
}