import 'package:checkin_medicine/features/medicines_management/data/models/ingredient_row.dart';
import 'package:checkin_medicine/features/medicines_management/presentation/widgets/ingredient_form_picker/ingredient_form_picker_button.dart';
import 'package:checkin_medicine/features/medicines_management/presentation/widgets/nutrient_picker/nutrient_picker_button.dart';
import 'package:checkin_medicine/shared/widgets/amount_of_serving_input.dart';
import 'package:checkin_medicine/shared/widgets/unit_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';

class IngredientRowCard extends StatelessWidget {
  final IngredientRow row;

  final int pillsPerServing;

  final ValueChanged<IngredientRow> onChanged;

  final VoidCallback onDelete;

  const IngredientRowCard({
    super.key,
    required this.row,
    required this.pillsPerServing,
    required this.onChanged,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {


    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            /// Nutrient
            NutrientPickerButton(
              selectedName: row.nutrientName,
              onSelected: (nutrient) {
                onChanged(
                  row.copyWith(
                    nutrientId: nutrient.id,
                    nutrientName: nutrient.name,
                    nutrientUnit: nutrient.unit,
                    input: row.input.copyWith(unit: nutrient.unit ?? 'mg'),
                  ),
                );
              },
            ),
            const SizedBox(height: 12),

            /// Form
            IngredientFormPickerButton(
              nutrientId: row.nutrientId,
              selectedName: row.formName,
              onSelected: (form) {
                onChanged(
                  row.copyWith(
                    formName: form.name,
                    saltForm: form.saltForm,
                    input: row.input.copyWith(formId: form.id),
                  ),
                );
              },
            ),
            const SizedBox(height: 12),

            Row(
              children: [
                Expanded(
                  child: AmountOfServingField(
                    initialValue: 1,
                    onChanged: (value) {

                      onChanged(
                        row.copyWith(
                          input: row.input.copyWith(amountPerServing: value),
                        ),
                      );
                    },
            )


                ),

                const SizedBox(width: 12),

                SizedBox(
                  width: 100,
                  child: UnitDropdown(
                    value: row.input.unit,
                    onChanged: (value) {
                      if (value == null) return;

                      onChanged(
                        row.copyWith(
                          input: row.input.copyWith(
                            unit: value,
                          ),
                        ),
                      );
                    },
                  ),
                ),

                IconButton(onPressed: onDelete, icon: const Icon(Icons.delete)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
