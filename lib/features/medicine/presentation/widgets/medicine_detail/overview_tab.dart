import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../l10n/app_localizations.dart';
import '../../../data/models/medicine_detail_model.dart';

class OverviewTab
    extends StatelessWidget {
  final MedicineDetailModel
  medicine;

  const OverviewTab({
    required this.medicine,
  });

  @override
  Widget build(
      BuildContext context,
      ) {
    final t =
    AppLocalizations.of(
      context,
    )!;

    return ListView(
      children: [
        if (medicine.summary !=
            null)
          Container(
            padding:
            const EdgeInsets.all(
              16,
            ),
            decoration:
            BoxDecoration(
              color: Theme.of(
                context,
              ).colorScheme.surface,
              borderRadius:
              BorderRadius.circular(
                20,
              ),
            ),
            child:
            Column(
              crossAxisAlignment:
              CrossAxisAlignment
                  .start,
              children: [
                Text(
                  t.description,
                  style:
                  Theme.of(
                    context,
                  )
                      .textTheme
                      .titleMedium,
                ),

                const SizedBox(
                  height: 10,
                ),

                Text(
                  medicine
                      .summary!,
                  style:
                  const TextStyle(
                    height:
                    1.6,
                  ),
                ),
              ],
            ),
          ),

        const SizedBox(
          height: 16,
        ),

        Container(
          padding:
          const EdgeInsets.all(
            16,
          ),
          decoration:
          BoxDecoration(
            color: Theme.of(
              context,
            ).colorScheme.surface,
            borderRadius:
            BorderRadius.circular(
              20,
            ),
          ),
          child:
          Column(
            crossAxisAlignment:
            CrossAxisAlignment
                .start,
            children: [
              Text(
                t.ingredientSummary,
                style:
                Theme.of(
                  context,
                )
                    .textTheme
                    .titleMedium,
              ),

              const SizedBox(
                height:
                12,
              ),

              ...medicine
                  .ingredients
                  .map(
                    (item) =>
                    Padding(
                      padding:
                      const EdgeInsets.symmetric(
                        vertical:
                        8,
                      ),
                      child:
                      Row(
                        children: [
                          Expanded(
                            child:
                            Text(
                              item
                                  .ingredientForm
                                  ?.nutrient
                                  ?.name ??
                                  '-',
                            ),
                          ),

                          Text(
                            '${item.amountPerPill ?? 0} ${item.unit ?? ''}'
                                '${item.percentDv != null ? ' · ${item.percentDv}% DV' : ''}',
                            style:
                            const TextStyle(
                              fontWeight:
                              FontWeight.w600,
                            ),
                          ),
                        ],
                      ),
                    ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
