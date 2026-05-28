import 'package:flutter/material.dart';

import '../../../../../core/utils/bumber_formatter.dart';
import '../../../../nutrient/presentation/pages/nutrient_detail_page.dart';
import '../../../data/models/medicine_ingredient.dart';

class IngredientsTab extends StatelessWidget {
  final List<MedicineIngredient> ingredients;

  const IngredientsTab({
    super.key,
    required this.ingredients,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),

      child: Container(
        decoration: BoxDecoration(
          color: colorScheme.surfaceContainerLow,
          borderRadius: BorderRadius.circular(24),
        ),

        child: Column(
          children: ingredients.asMap().entries.map((entry) {
            final index = entry.key;
            final item = entry.value;

            final form = item.ingredientForm;
            final nutrient = form?.nutrient;

            final isLast = index == ingredients.length - 1;

            return Column(
              children: [
                InkWell(
                  borderRadius: BorderRadius.circular(24),

                  onTap: () {
                    final slug = nutrient?.slug;

                    if (slug == null) return;

                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => NutrientDetailPage(
                          slug: slug,
                          selectedFormSlug: form?.slug,
                        ),
                      ),
                    );
                  },

                  child: Padding(
                    padding: const EdgeInsets.all(20),

                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,

                      children: [
                        /// LEFT INFO
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                nutrient?.name ?? form?.name ?? '—',
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall
                                    ?.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),

                              if (form?.saltForm != null &&
                                  form!.saltForm!.isNotEmpty)
                                Padding(
                                  padding: const EdgeInsets.only(top: 4),
                                  child: Text(
                                    form.saltForm!,
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(
                                      color: colorScheme.onSurfaceVariant,
                                    ),
                                  ),
                                ),
                            ],
                          ),
                        ),

                        const SizedBox(width: 16),

                        /// RIGHT SIDE
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ConstrainedBox(
                              constraints: const BoxConstraints(maxWidth: 130),

                              child: Text(
                                NumberFormatter.dosage(
                                  amount: item.amountPerPill,
                                  unit: item.unit,
                                  percentDv: item.percentDv,
                                ),

                                textAlign: TextAlign.right,
                                softWrap: true,

                                style: Theme.of(context)
                                    .textTheme
                                    .labelLarge
                                    ?.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),

                            const SizedBox(width: 8),

                            Icon(
                              Icons.chevron_right,
                              size: 20,
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),

                if (!isLast)
                  Divider(
                    height: 1,
                    indent: 20,
                    endIndent: 20,
                    color: colorScheme.outlineVariant,
                  ),
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}