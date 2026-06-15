import 'package:checkin_medicine/features/nutrient/data/models/nutrient_model.dart';
import 'package:checkin_medicine/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/nutrient_search_provider.dart';

class NutrientPickerDialog extends ConsumerWidget {
  final ValueChanged<NutrientModel> onSelected;

  const NutrientPickerDialog({super.key, required this.onSelected});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = AppLocalizations.of(context)!;

    final nutrients = ref.watch(nutrientSearchProvider);

    return AlertDialog(
      title: Text(t.selectNutrient),

      content: SizedBox(
        width: 500,
        height: 500,
        child: Column(
          children: [
            TextField(
              decoration: InputDecoration(
                hintText: t.search,
                prefixIcon: Icon(Icons.search),
              ),
              onChanged: (value) {
                ref.read(nutrientSearchQueryProvider.notifier).state = value;
              },
            ),

            const SizedBox(height: 12),

            Expanded(
              child: nutrients.when(
                loading: () => const Center(child: CircularProgressIndicator()),

                error: (e, _) => Center(child: Text(e.toString())),

                data: (list) {
                  if (list.isEmpty) {
                    return Center(child: Text(t.noIngredientFormsFound));
                  }

                  return ListView.builder(
                    itemCount: list.length,
                    itemBuilder: (_, index) {
                      final nutrient = list[index];

                      return ListTile(
                        title: Text(nutrient.name),

                        subtitle: Text(nutrient.unit ?? ''),

                        onTap: () {
                          onSelected(nutrient);

                          Navigator.pop(context);
                        },
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
