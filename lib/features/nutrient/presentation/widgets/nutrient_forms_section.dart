import 'package:flutter/material.dart';

import '../../../../../l10n/app_localizations.dart';
import '../../data/models/nutrient_detail_model.dart';

class NutrientFormsSection
    extends StatelessWidget {
  final NutrientDetailModel
  nutrient;

  const NutrientFormsSection({
    super.key,
    required this.nutrient,
  });

  @override
  Widget build(
      BuildContext context) {
    final t =
    AppLocalizations.of(
      context,
    )!;

    return Column(
      crossAxisAlignment:
      CrossAxisAlignment
          .start,
      children: [
        Text(
          t.commonForms,
          style:
          Theme.of(context)
              .textTheme
              .titleLarge,
        ),

        const SizedBox(
          height: 12,
        ),

        ListView.separated(
          shrinkWrap: true,
          physics:
          const NeverScrollableScrollPhysics(),
          itemCount:
          nutrient
              .ingredientForms
              .length,
          separatorBuilder:
              (_, __) =>
          const SizedBox(
            height: 12,
          ),
          itemBuilder:
              (context, index) {
            final form =
            nutrient
                .ingredientForms[
            index];

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

              child: Row(
                children: [
                  Expanded(
                    child:
                    Column(
                      crossAxisAlignment:
                      CrossAxisAlignment
                          .start,
                      children: [
                        Text(
                          form.name,
                          style:
                          const TextStyle(
                            fontWeight:
                            FontWeight.bold,
                          ),
                        ),

                        const SizedBox(
                          height:
                          6,
                        ),

                        Text(
                          '${form.saltForm ?? '-'} · ${t.absorption}: ${form.bioavailability ?? '-'}',
                          style:
                          const TextStyle(
                            color:
                            Colors.grey,
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
        ),
      ],
    );
  }
}