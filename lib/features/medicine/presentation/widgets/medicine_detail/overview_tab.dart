import 'package:flutter/material.dart';

import '../../../../../core/utils/bumber_formatter.dart';
import '../../../../../l10n/app_localizations.dart';
import '../../../data/models/medicine_detail_model.dart';

class OverviewTab
    extends StatelessWidget {
  final Medicine medicine;

  const OverviewTab({
    super.key,
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

    final colorScheme =
        Theme.of(context)
            .colorScheme;

    return SingleChildScrollView(
      physics:
      const BouncingScrollPhysics(),

      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment
            .start,

        children: [
          /// SUMMARY
          if (medicine.summary !=
              null &&
              medicine
                  .summary!
                  .isNotEmpty)
            _OverviewCard(
              title:
              t.description,

              icon: Icons
                  .description_outlined,

              child: Text(
                medicine.summary!,
                style: Theme.of(
                    context)
                    .textTheme
                    .bodyMedium
                    ?.copyWith(
                  height:
                  1.75,

                  color:
                  colorScheme
                      .onSurfaceVariant,
                ),
              ),
            ),

          if (medicine.summary !=
              null &&
              medicine
                  .summary!
                  .isNotEmpty)
            const SizedBox(
              height: 20,
            ),

          /// INGREDIENT SUMMARY
          _OverviewCard(
            title:
            t.ingredientSummary,

            icon:
            Icons.science_outlined,

            child: Column(
              children: medicine
                  .ingredients
                  .asMap()
                  .entries
                  .map(
                    (entry) {
                  final index =
                      entry.key;

                  final item =
                      entry.value;

                  final isLast =
                      index ==
                          medicine
                              .ingredients
                              .length -
                              1;

                  return Column(
                    children: [
                      Padding(
                        padding:
                        const EdgeInsets
                            .symmetric(
                          vertical:
                          12,
                        ),

                        child: Row(
                          crossAxisAlignment:
                          CrossAxisAlignment
                              .center,

                          children: [

                            /// NAME
                            Expanded(
                              child:
                              Column(
                                crossAxisAlignment:
                                CrossAxisAlignment
                                    .start,

                                children: [
                                  Text(
                                    item
                                        .ingredientForm
                                        ?.nutrient
                                        ?.name ??
                                        '-',

                                    style: Theme.of(
                                        context)
                                        .textTheme
                                        .titleSmall
                                        ?.copyWith(
                                      fontWeight:
                                      FontWeight
                                          .w700,
                                    ),
                                  ),

                                  const SizedBox(
                                    height:
                                    4,
                                  ),

                                  Text(
                                    item.unit ??
                                        '',

                                    style: Theme.of(
                                        context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(
                                      color:
                                      colorScheme
                                          .onSurfaceVariant,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                            const SizedBox(
                              width:
                              12,
                            ),

                            /// DOSAGE
                            Text(
                              NumberFormatter
                                  .dosage(
                                amount: item
                                    .amountPerPill,

                                unit:
                                item.unit,

                                percentDv:
                                item.percentDv,
                              ),

                              style: Theme.of(
                                  context)
                                  .textTheme
                                  .labelLarge
                                  ?.copyWith(
                                fontWeight:
                                FontWeight
                                    .w700,
                              ),
                            ),
                          ],
                        ),
                      ),

                      if (!isLast)
                        Divider(
                          height:
                          1,
                          color: colorScheme
                              .outlineVariant,
                        ),
                    ],
                  );
                },
              ).toList(),
            ),
          ),

          const SizedBox(
            height: 24,
          ),
        ],
      ),
    );
  }
}

class _OverviewCard
    extends StatelessWidget {
  final String title;
  final IconData icon;
  final Widget child;

  const _OverviewCard({
    required this.title,
    required this.icon,
    required this.child,
  });

  @override
  Widget build(
      BuildContext context,
      ) {
    final colorScheme =
        Theme.of(context)
            .colorScheme;

    return Container(
      width:
      double.infinity,

      padding:
      const EdgeInsets.all(
        20,
      ),

      decoration:
      BoxDecoration(
        color: colorScheme
            .surfaceContainerLow,

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
            children: [
              Icon(
                icon,
                size: 20,
                color:
                colorScheme
                    .primary,
              ),

              const SizedBox(
                width: 10,
              ),

              Text(
                title,
                style: Theme.of(
                    context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(
                  fontWeight:
                  FontWeight
                      .w700,
                ),
              ),
            ],
          ),

          const SizedBox(
            height: 18,
          ),

          child,
        ],
      ),
    );
  }
}