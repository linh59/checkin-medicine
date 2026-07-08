import 'package:checkin_medicine/core/extension/medicine_form_extension.dart';
import 'package:checkin_medicine/core/utils/bumber_formatter.dart';
import 'package:checkin_medicine/features/medicine/data/models/medicine_ingredient.dart';
import 'package:checkin_medicine/features/nutrient/presentation/pages/nutrient_detail_page.dart';
import 'package:checkin_medicine/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class IngredientsTab extends StatelessWidget {
  final List<MedicineIngredient> ingredients;
  final int pillsPerServing;
  final String? form;

  const IngredientsTab({
    super.key,
    required this.ingredients,
    required this.pillsPerServing,
    this.form,
  });

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;

    final servingText =
        '${t.basedOn} 1 ${form?.localized(t) ?? ''}';

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding:
            const EdgeInsets.only(left: 20, right: 20, top: 12),
            child: Text(
              servingText,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ),

          Container(
            decoration: BoxDecoration(
              color: colorScheme.surfaceContainerLow,
              borderRadius: BorderRadius.circular(24),
            ),
            child: Column(
              children: ingredients.asMap().entries.map((entry) {
                final index = entry.key;
                final item = entry.value;

                final nutrient = item.nutrient;

                final formText = item.forms
                    .map((e) => e.saltForm ?? e.name)
                    .whereType<String>()
                    .where((e) => e.trim().isNotEmpty)
                    .join(', ');

                final isLast =
                    index == ingredients.length - 1;

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
                              selectedFormSlug: item.forms.isNotEmpty
                                  ? item.forms.first.slug
                                  : null,
                            ),
                          ),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Row(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    nutrient?.name ?? '—',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleSmall
                                        ?.copyWith(
                                      fontWeight:
                                      FontWeight.w700,
                                    ),
                                  ),

                                  if (formText.isNotEmpty)
                                    Padding(
                                      padding:
                                      const EdgeInsets.only(
                                          top: 4),
                                      child: Text(
                                        '(as $formText)',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodySmall
                                            ?.copyWith(
                                          color: colorScheme
                                              .onSurfaceVariant,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),

                            const SizedBox(width: 16),

                            Row(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment:
                              CrossAxisAlignment.center,
                              children: [
                                ConstrainedBox(
                                  constraints:
                                  const BoxConstraints(
                                    maxWidth: 130,
                                  ),
                                  child: Text(
                                    NumberFormatter.dosage(
                                      amount:
                                      item.amountPerServing,
                                      unit: item.unit
                                    ),
                                    textAlign:
                                    TextAlign.right,
                                    softWrap: true,
                                    style: Theme.of(context)
                                        .textTheme
                                        .labelLarge
                                        ?.copyWith(
                                      fontWeight:
                                      FontWeight.w700,
                                    ),
                                  ),
                                ),

                                const SizedBox(width: 8),

                                Icon(
                                  Icons.chevron_right,
                                  size: 20,
                                  color: colorScheme
                                      .onSurfaceVariant,
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
                        color:
                        colorScheme.outlineVariant,
                      ),
                  ],
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}