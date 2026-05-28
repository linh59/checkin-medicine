import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../data/models/medicine_detail_model.dart';

class MedicineHeader
    extends StatelessWidget {
  final Medicine
  medicine;

  const MedicineHeader({
    required this.medicine,
  });

  @override
  Widget build(
      BuildContext context,
      ) {
    final theme =
    Theme.of(context);

    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: 30),

      decoration:
      BoxDecoration(
        color: theme
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
          Container(
            width: 68,
            height: 68,
            decoration:
            BoxDecoration(
              color:
              WellnessColors.primary
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
              Icons.medication,
              color:
              WellnessColors.primary,
              size: 34,
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
                  medicine
                      .brand,
                  style: theme
                      .textTheme
                      .titleLarge
                      ?.copyWith(
                    fontWeight:
                    FontWeight
                        .bold,
                  ),
                ),

                if (medicine
                    .genericName !=
                    null)
                  Padding(
                    padding:
                    const EdgeInsets.only(
                      top: 6,
                    ),
                    child: Text(
                      medicine
                          .genericName!,
                      style:
                      const TextStyle(
                        color:
                        Colors.grey,
                      ),
                    ),
                  ),

                const SizedBox(
                  height: 10,
                ),

                Wrap(
                  spacing:
                  8,
                  runSpacing:
                  8,
                  children: [

                    if (medicine
                        .servingSize !=
                        null)
                      Chip(
                        label:
                        Text(
                          medicine
                              .servingSize!,
                        ),
                      ),
                  ],
                ),

                if (medicine
                    .manufacturer !=
                    null)
                  Padding(
                    padding:
                    const EdgeInsets.only(
                      top: 8,
                    ),
                    child: Text(
                      medicine
                          .manufacturer!,
                      style:
                      const TextStyle(
                        color:
                        Colors.grey,
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
