import 'package:checkin_medicine/core/extension/medicine_form_extension.dart';
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
    final hasServingData = medicine.ingredients.any(
          (e) => e.amountPerServing != null,
    );

    final servingText =
        '${t.basedOn} ${hasServingData ? medicine.pillsPerServing ?? 1 : 1} ${medicine.form.localized(t) }';
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
              t.summary,

              icon: Icons
                  .summarize_outlined,

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

          medicine.description != null ? _OverviewCard(
            title:
            t.description,

            icon: Icons
                .description_outlined,

            child: Text(
              medicine.description!,
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
          ) : SizedBox(),

          /// INGREDIENT SUMMARY
          _OverviewCard(
            title:
            t.ingredientSummary,
            subtitle: servingText,
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
                                    item.ingredientForm?.saltForm ??
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
                            // Amount per serving
                            if(item.amountPerServing != null && item.amountPerServing! > 0)
                              Text(
                                NumberFormatter
                                    .dosage(
                                  amount: item
                                      .amountPerServing,

                                  unit:
                                  item.unit,


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
                            /// Amount per pill
                            if(item.amountPerPill! > 0)
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

          if ((medicine.sourceName ?? '').isNotEmpty ||
              (medicine.sourceUrl ?? '').isNotEmpty)
            _OverviewCard(
              title: t.sourceName,
              icon: Icons.link_outlined,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  if ((medicine.sourceName ?? '').isNotEmpty)
                    Text(
                      medicine.sourceName ?? '',
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall
                          ?.copyWith(
                        fontWeight: FontWeight.w600,
                      ),
                    ),

                  if (medicine.sourceUrl != null &&
                      medicine.sourceUrl!.isNotEmpty) ...[
                    const SizedBox(height: 8),

                    GestureDetector(
                      onTap: () {
                        // TODO: mở link
                        // launchUrl(Uri.parse(medicine.sourceUrl!));
                      },
                      child: Text(
                        medicine.sourceUrl!,
                        style: TextStyle(
                          color: Theme.of(context).colorScheme.primary,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ],
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

class _OverviewCard extends StatelessWidget {
  final String title;
  final String? subtitle;
  final IconData icon;
  final Widget child;

  const _OverviewCard({
    required this.title,
    this.subtitle,
    required this.icon,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(
                icon,
                size: 20,
                color: colorScheme.primary,
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Text(
                  title,
                  style: Theme.of(context)
                      .textTheme
                      .titleMedium
                      ?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ],
          ),

          if (subtitle != null) ...[
            const SizedBox(height: 4),
            Text(
              subtitle!,
              style: Theme.of(context)
                  .textTheme
                  .bodyLarge
                  ?.copyWith(
                color: colorScheme.onSurfaceVariant,
              ),
            ),
          ],


          child,
        ],
      ),
    );
  }
}