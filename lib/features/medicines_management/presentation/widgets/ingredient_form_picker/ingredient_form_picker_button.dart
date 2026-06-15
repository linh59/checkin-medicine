import 'package:checkin_medicine/features/medicines_management/presentation/widgets/ingredient_form_picker/ingredient_form_dialog.dart';
import 'package:checkin_medicine/features/nutrient/data/models/ingredient_form_model.dart';
import 'package:flutter/material.dart';



class IngredientFormPickerButton extends StatelessWidget {
  final String? nutrientId;

  final String? selectedName;

  final ValueChanged<IngredientForm> onSelected;

  const IngredientFormPickerButton({
    super.key,
    required this.nutrientId,
    required this.selectedName,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    return OutlinedButton(
      onPressed: nutrientId == null
          ? null
          : () async {
        final form = await showDialog<IngredientForm>(
          context: context,
          builder: (ctx) => IngredientFormDialog(
            nutrientId: nutrientId!,
          ),
        );

        if (form != null) {
          onSelected(form);
        }
      },
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(selectedName ?? 'Select form'),
      ),
    );
  }
}



