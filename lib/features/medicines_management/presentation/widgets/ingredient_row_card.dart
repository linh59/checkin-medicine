import 'package:checkin_medicine/features/medicines_management/data/models/ingredient_row.dart';
import 'package:checkin_medicine/features/medicines_management/presentation/widgets/ingredient_form_picker/ingredient_forms_picker_button.dart';
import 'package:checkin_medicine/features/medicines_management/presentation/widgets/nutrient_picker/nutrient_picker_button.dart';
import 'package:checkin_medicine/shared/widgets/amount_of_serving_input.dart';
import 'package:checkin_medicine/shared/widgets/unit_dropdown.dart';
import 'package:flutter/material.dart';


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

                    nutrientName: nutrient.name,

                    nutrientUnit: nutrient.unit,

                    forms: const [],

                    input: row.input.copyWith(
                      nutrientId: nutrient.id,
                      formIds: const [],
                      unit: nutrient.unit ?? 'mg',
                    ),
                  ),
                );

              },
            ),


            const SizedBox(height: 12),



            /// Forms optional
            if(row.input.nutrientId.isNotEmpty)

              IngredientFormsPickerButton(

                nutrientId: row.input.nutrientId,

                selectedForms: row.forms,


                onSelected: (forms){

                  onChanged(
                    row.copyWith(

                      forms: forms,

                      input: row.input.copyWith(
                        formIds: forms
                            .map((e)=>e.id)
                            .toList(),
                      ),

                    ),
                  );

                },
              ),



            const SizedBox(height: 12),



            Row(
              children: [


                Expanded(
                  child: AmountOfServingField(

                    onChanged: (value){

                      onChanged(
                        row.copyWith(

                          input: row.input.copyWith(
                            amountPerServing: value,
                          ),

                        ),
                      );

                    },

                  ),
                ),



                const SizedBox(width:12),



                SizedBox(
                  width:100,

                  child: UnitDropdown(

                    value: row.input.unit,

                    onChanged:(value){

                      if(value==null) return;


                      onChanged(
                        row.copyWith(

                          input: row.input.copyWith(
                            unit:value,
                          ),

                        ),
                      );

                    },

                  ),
                ),



                IconButton(
                  onPressed:onDelete,

                  icon: const Icon(
                    Icons.delete_outline,
                  ),
                ),

              ],
            )

          ],
        ),
      ),
    );
  }
}