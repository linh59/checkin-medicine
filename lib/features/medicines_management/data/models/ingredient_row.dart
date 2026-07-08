import 'package:checkin_medicine/features/nutrient/data/models/ingredient_form_model.dart';
import 'medicine_ingredient_input.dart';

class IngredientRow {
  final String localId;

  final String? nutrientName;

  final String? nutrientUnit;

  /// Multi forms
  final List<IngredientForm> forms;

  final MedicineIngredientInput input;

  const IngredientRow({
    required this.localId,
    required this.input,
    this.nutrientName,
    this.nutrientUnit,
    this.forms = const [],
  });


  IngredientRow copyWith({
    String? nutrientName,
    String? nutrientUnit,
    List<IngredientForm>? forms,
    MedicineIngredientInput? input,
  }) {
    return IngredientRow(
      localId: localId,
      nutrientName: nutrientName ?? this.nutrientName,
      nutrientUnit: nutrientUnit ?? this.nutrientUnit,
      forms: forms ?? this.forms,
      input: input ?? this.input,
    );
  }


  factory IngredientRow.empty() {
    return IngredientRow(
      localId: DateTime.now()
          .millisecondsSinceEpoch
          .toString(),

      nutrientName: null,
      nutrientUnit: null,

      forms: const [],

      input: const MedicineIngredientInput(
        nutrientId: '',
        formIds: [],
        amountPerServing: 0,
        unit: 'mg',
      ),
    );
  }
}