import 'package:flutter/material.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../l10n/app_localizations.dart';
import '../../../../core/utils/bumber_formatter.dart';
import '../../data/models/nutrient_model.dart';

class NutrientSafeLimitSection extends StatelessWidget {
  final NutrientModel nutrient;

  const NutrientSafeLimitSection({super.key, required this.nutrient});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          t.safeDosageByGroup,
          style: Theme.of(context).textTheme.titleLarge,
        ),

        const SizedBox(height: 12),

        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
            borderRadius: BorderRadius.circular(20),
          ),

          child: nutrient.safeLimits.isEmpty
              ? Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(t.noData),
                )
              : Column(
                  children: nutrient.safeLimits
                      .map(
                        (item) => Container(
                          padding: const EdgeInsets.all(16),

                          decoration: BoxDecoration(
                            border: Border(
                              bottom: BorderSide(
                                color: Colors.grey.withOpacity(0.12),
                              ),
                            ),
                          ),

                          child: Row(
                            children: [
                              const Icon(
                                Icons.shield,
                                color: WellnessColors.primary,
                              ),

                              const SizedBox(width: 10),

                              Expanded(
                                child: Text(
                                  _groupLabel(item.groupKind, t),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),

                              Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  if (item.rda != null)
                                    Text(
                                      '${t.rda}: '
                                      '${NumberFormatter.withUnit(item.rda, nutrient.unit)}',
                                    ),

                                  if (item.ul != null)
                                    Text(
                                      '${t.ul}: '
                                      '${NumberFormatter.withUnit(item.ul, nutrient.unit)}',
                                      style: const TextStyle(
                                        color: Colors.grey,
                                      ),
                                    ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      )
                      .toList(),
                ),
        ),
      ],
    );
  }

  String _groupLabel(String value, AppLocalizations t) {
    switch (value) {
      case 'adult_male':
        return t.adultMale;

      case 'adult_female':
        return t.adultFemale;

      case 'pregnant':
        return t.pregnant;

      case 'child':
        return t.child;

      default:
        return value;
    }
  }
}
