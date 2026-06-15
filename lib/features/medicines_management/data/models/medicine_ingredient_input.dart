class MedicineIngredientInput {
  final String formId;

  final double amountPerPill;

  final String unit;

  final double? percentDv;

  const MedicineIngredientInput({
    required this.formId,
    required this.amountPerPill,
    required this.unit,
    this.percentDv,
  });

  factory MedicineIngredientInput.fromJson(Map<String, dynamic> json) {
    return MedicineIngredientInput(
      formId: json['form_id']?.toString() ?? '',

      amountPerPill:
          double.tryParse(json['amount_per_pill']?.toString() ?? '') ?? 0,

      unit: json['unit']?.toString() ?? '',

      percentDv: double.tryParse(json['percent_dv']?.toString() ?? ''),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'form_id': formId,
      'amount_per_pill': amountPerPill,
      'unit': unit,
      'percent_dv': percentDv,
    };
  }

  MedicineIngredientInput copyWith({
    String? formId,
    double? amountPerPill,
    String? unit,
    double? percentDv,
  }) {
    return MedicineIngredientInput(
      formId: formId ?? this.formId,
      amountPerPill: amountPerPill ?? this.amountPerPill,
      unit: unit ?? this.unit,
      percentDv: percentDv ?? this.percentDv,
    );
  }
}
