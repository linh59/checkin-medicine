import 'package:flutter/material.dart';

import '../../../../../l10n/app_localizations.dart';
import '../../data/models/nutrient_model.dart';
import '../pages/form_detail_page.dart';

class NutrientFormsSection
    extends StatelessWidget {
  final NutrientModel nutrient;

  /// form slug của thuốc hiện tại
  final String? selectedFormSlug;

  const NutrientFormsSection({
    super.key,
    required this.nutrient,
    this.selectedFormSlug,
  });

  @override
  Widget build(
      BuildContext context,
      ) {
    final t =
    AppLocalizations.of(
      context,
    )!;

    if (nutrient.forms.isEmpty) {
      return const SizedBox();
    }

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
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          physics:
          const NeverScrollableScrollPhysics(),

          itemCount:
          nutrient
              .forms
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
                .forms[index];

            /// FIX compare
            final isSelected =
                form.slug ==
                    selectedFormSlug;

            return InkWell(
              borderRadius:
              BorderRadius.circular(
                20,
              ),

              onTap: () {
                Navigator.push(
                  context,

                  MaterialPageRoute(
                    builder:
                        (_) =>
                        FormDetailPage(
                          slug:
                          form.slug,
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
                  color:
                  Theme.of(
                    context,
                  )
                      .colorScheme
                      .surface,

                  borderRadius:
                  BorderRadius.circular(
                    20,
                  ),
                ),

                child: Row(
                  crossAxisAlignment:
                  CrossAxisAlignment
                      .start,

                  children: [
                    Expanded(
                      child:
                      Column(
                        crossAxisAlignment:
                        CrossAxisAlignment
                            .start,

                        children: [
                          /// FORM NAME
                          Text(
                            form.name,

                            style:
                            Theme.of(
                              context,
                            )
                                .textTheme
                                .titleMedium
                                ?.copyWith(
                              fontWeight:
                              FontWeight
                                  .w700,
                            ),
                          ),

                          const SizedBox(
                            height:
                            6,
                          ),

                          /// SALT + ABSORPTION
                          Text(
                            '${form.saltForm ?? '-'} · ${t.absorption}: ${form.bioavailability ?? '-'}',

                            style:
                            TextStyle(
                              color: Theme.of(
                                  context)
                                  .colorScheme
                                  .onSurfaceVariant,

                              height:
                              1.4,
                            ),
                          ),

                          /// SELECTED FORM
                          if (isSelected)
                            Padding(
                              padding:
                              const EdgeInsets.only(
                                top:
                                12,
                              ),

                              child:
                              Chip(
                                visualDensity:
                                VisualDensity.compact,

                                avatar:
                                const Icon(
                                  Icons
                                      .medication_outlined,

                                  size:
                                  18,
                                ),

                                label:
                                Text(
                                  t.usedInMedicine,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),

                    const SizedBox(
                      width: 8,
                    ),

                    Icon(
                      Icons
                          .chevron_right,

                      color:
                      Theme.of(
                        context,
                      )
                          .colorScheme
                          .onSurfaceVariant,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}