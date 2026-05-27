import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../l10n/app_localizations.dart';
import '../../../data/models/medicine_detail_model.dart';

class IngredientsTab
    extends StatelessWidget {
  final MedicineDetailModel
  medicine;

  const IngredientsTab({
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
    return ListView.separated(
      itemCount:
      medicine
          .ingredients
          .length,
      separatorBuilder:
          (_, __) =>
      const SizedBox(
        height: 12,
      ),
      itemBuilder:
          (
          context,
          index,
          ) {
        final item =
        medicine
            .ingredients[index];

        final form =
            item
                .ingredientForm;

        return Container(
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
          Row(
            children: [
              Container(
                width:
                52,
                height:
                52,
                decoration:
                BoxDecoration(
                  color:
                  WellnessColors.primary
                      .withOpacity(
                    0.12,
                  ),
                  borderRadius:
                  BorderRadius.circular(
                    14,
                  ),
                ),
                child:
                const Icon(
                  Icons.science,
                  color:
                  WellnessColors.primary,
                ),
              ),

              const SizedBox(
                width:
                12,
              ),

              Expanded(
                child:
                Column(
                  crossAxisAlignment:
                  CrossAxisAlignment
                      .start,
                  children: [
                    Text(
                      form
                          ?.nutrient
                          ?.name ??
                          '',
                      style:
                      const TextStyle(
                        fontWeight:
                        FontWeight.bold,
                      ),
                    ),

                    const SizedBox(
                      height:
                      4,
                    ),

                    Text(
                      '${form?.saltForm ?? ''} · ${item.amountPerPill ?? 0} ${item.unit ?? ''}',
                      style:
                      const TextStyle(
                        color:
                        Colors.grey,
                      ),
                    ),

                    if (form
                        ?.bioavailability !=
                        null)
                      Padding(
                        padding:
                        const EdgeInsets.only(
                          top:
                          6,
                        ),
                        child:
                        Text(
                          t.absorption + ': ${form!.bioavailability}',
                          style:
                          const TextStyle(
                            color:
                            WellnessColors.primary,
                            fontWeight:
                            FontWeight.w600,
                          ),
                        ),
                      ),
                  ],
                ),
              ),

              const Icon(
                Icons
                    .chevron_right,
              ),
            ],
          ),
        );
      },
    );
  }
}
