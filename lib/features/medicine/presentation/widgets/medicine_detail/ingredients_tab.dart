import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/utils/bumber_formatter.dart';
import '../../../../../l10n/app_localizations.dart';
import '../../../../nutrient/presentation/pages/nutrient_detail_page.dart';
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

        return InkWell(
            borderRadius:
            BorderRadius.circular(
              20,
            ),

            onTap: () {
              final slug =
                  form
                      ?.nutrient
                      ?.slug;

              if (slug == null) {
                return;
              }

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder:
                      (_) =>
                      NutrientDetailPage(
                        slug: slug,
                      ),
                ),
              );
            },

            child: Container(
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
                      '${form?.saltForm ?? '—'}'
                          ' · '
                          '${NumberFormatter.withUnit(
                        item.amountPerPill,
                        item.unit,
                      )}',
                      style:
                      const TextStyle(
                        color: Colors.grey,
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
        )
        );
      },
    );
  }
}
