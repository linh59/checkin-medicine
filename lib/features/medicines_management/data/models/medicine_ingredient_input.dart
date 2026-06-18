class MedicineIngredientInput {
  final String formId;

  final double amountPerServing;

  final String unit;

  final double? percentDv;

  const MedicineIngredientInput({
    required this.formId,
    required this.amountPerServing,
    required this.unit,
    this.percentDv,
  });

  factory MedicineIngredientInput.fromJson(Map<String, dynamic> json) {
    return MedicineIngredientInput(
      formId: json['form_id']?.toString() ?? '',

      amountPerServing:
          double.tryParse(json['amount_per_serving']?.toString() ?? '') ?? 0,

      unit: json['unit']?.toString() ?? '',

      percentDv: double.tryParse(json['percent_dv']?.toString() ?? ''),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'form_id': formId,
      'amount_per_serving': amountPerServing,
      'unit': unit,
      'percent_dv': percentDv,
    };
  }

  MedicineIngredientInput copyWith({
    String? formId,
    double? amountPerServing,
    String? unit,
    double? percentDv,
  }) {
    return MedicineIngredientInput(
      formId: formId ?? this.formId,
      amountPerServing: amountPerServing ?? this.amountPerServing,
      unit: unit ?? this.unit,
      percentDv: percentDv ?? this.percentDv,
    );
  }
}
