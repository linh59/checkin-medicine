import '../../data/models/medicine_ingredient_input.dart';

class IngredientRow {
  final String localId;

  final String? nutrientId;
  final String? nutrientName;
  final String? nutrientUnit;

  final String? formName;
  final String? saltForm;

  final MedicineIngredientInput input;

  IngredientRow({
    required this.localId,
    required this.input,
    this.nutrientId,
    this.nutrientName,
    this.nutrientUnit,
    this.formName,
    this.saltForm,
  });

  IngredientRow copyWith({
    String? nutrientId,
    String? nutrientName,
    String? nutrientUnit,
    String? formName,
    String? saltForm,
    MedicineIngredientInput? input,
  }) {
    return IngredientRow(
      localId: localId,
      nutrientId: nutrientId ?? this.nutrientId,
      nutrientName: nutrientName ?? this.nutrientName,
      nutrientUnit: nutrientUnit ?? this.nutrientUnit,
      formName: formName ?? this.formName,
      saltForm: saltForm ?? this.saltForm,
      input: input ?? this.input,
    );
  }

  factory IngredientRow.empty() {
    return IngredientRow(
      nutrientId: null,
      nutrientName: null,
      nutrientUnit: null,
      formName: null,
      saltForm: null,
      input: const MedicineIngredientInput(
        formId: '',
        amountPerPill: 0,
        unit: 'mg',
      ),
      localId: '',
    );
  }
}
