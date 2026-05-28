import 'package:flutter/material.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../l10n/app_localizations.dart';
import '../../data/models/nutrient_model.dart';

class NutrientHeader
    extends StatelessWidget {
  final NutrientModel
  nutrient;

  const NutrientHeader({
    super.key,
    required this.nutrient,
  });

  @override
  Widget build(
      BuildContext context) {
    final theme =
    Theme.of(context);

    final t =
    AppLocalizations.of(
      context,
    )!;

    return Container(
      width: double.infinity,
      padding:
      const EdgeInsets.all(
        18,
      ),
      decoration:
      BoxDecoration(
        color: theme
            .colorScheme
            .surface,
        borderRadius:
        BorderRadius.circular(
          24,
        ),
      ),
      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment
            .start,
        children: [
          Row(
            crossAxisAlignment:
            CrossAxisAlignment
                .start,
            children: [
              Container(
                width: 68,
                height: 68,
                decoration:
                BoxDecoration(
                  color:
                  WellnessColors
                      .primary
                      .withOpacity(
                    0.12,
                  ),
                  borderRadius:
                  BorderRadius.circular(
                    18,
                  ),
                ),
                child:
                const Icon(
                  Icons.science,
                  size: 34,
                  color:
                  WellnessColors
                      .primary,
                ),
              ),

              const SizedBox(
                width: 14,
              ),

              Expanded(
                child:
                Column(
                  crossAxisAlignment:
                  CrossAxisAlignment
                      .start,
                  children: [
                    Text(
                      nutrient
                          .name,
                      style: theme
                          .textTheme
                          .headlineSmall
                          ?.copyWith(
                        fontWeight:
                        FontWeight
                            .bold,
                      ),
                    ),

                    const SizedBox(
                      height: 10,
                    ),

                    Chip(
                      label:
                      Text(
                        _getCategoryLabel(
                          nutrient
                              .category,
                          t,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          if (nutrient.summary !=
              null) ...[
            const SizedBox(
              height: 18,
            ),

            Text(
              nutrient.summary!,
              style:
              const TextStyle(
                height: 1.6,
              ),
            ),
          ],

          if (nutrient
              .whyMatters !=
              null) ...[
            const SizedBox(
              height: 16,
            ),

            Container(
              width:
              double.infinity,
              padding:
              const EdgeInsets.all(
                14,
              ),
              decoration:
              BoxDecoration(
                color:
                WellnessColors
                    .primary
                    .withOpacity(
                  0.08,
                ),
                borderRadius:
                BorderRadius.circular(
                  18,
                ),
              ),
              child: RichText(
                text: TextSpan(
                  style:
                  DefaultTextStyle.of(
                    context,
                  ).style,
                  children: [
                    TextSpan(
                      text:
                      '${t.whyImportant}: ',
                      style:
                      const TextStyle(
                        fontWeight:
                        FontWeight
                            .bold,
                        color:
                        WellnessColors.primary,
                      ),
                    ),
                    TextSpan(
                      text:
                      nutrient
                          .whyMatters!,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }

  String _getCategoryLabel(
      String? category,
      AppLocalizations t,
      ) {
    switch (category) {
      case 'vitamin':
        return t.vitamin;
      case 'mineral':
        return t.mineral;
      case 'amino_acid':
        return t.aminoAcid;
      case 'herb':
        return t.herb;
      default:
        return category ?? '-';
    }
  }
}