import 'package:checkin_medicine/features/medicines_management/data/models/ingredient_row.dart';
import 'package:checkin_medicine/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

import 'ingredient_row_card.dart';

class IngredientPicker extends StatelessWidget {
  final List<IngredientRow> rows;
  final int pillsPerServing;
  final ValueChanged<List<IngredientRow>> onChanged;

  const IngredientPicker({
    super.key,
    required this.rows,
    required this.pillsPerServing,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return Column(
      children: [
        if (pillsPerServing > 1)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(12),
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: Colors.blue.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
            ),
            child: Text(t.ingredientDoseCalculation(pillsPerServing)),
          ),

        ...rows.asMap().entries.map((entry) {
          final index = entry.key;
          final row = entry.value;

          return Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: IngredientRowCard(
              row: row,
              pillsPerServing: pillsPerServing,
              onChanged: (updated) {
                final newRows = [...rows];
                newRows[index] = updated;

                onChanged(newRows);
              },
              onDelete: () {
                final newRows = [...rows];
                newRows.removeAt(index);

                onChanged(newRows);
              },
            ),
          );
        }),

        OutlinedButton.icon(
          onPressed: () {
            onChanged([...rows, IngredientRow.empty()]);
          },
          icon: const Icon(Icons.add),
          label: Text(t.addIngredient),
        ),
      ],
    );
  }
}
