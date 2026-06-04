import 'package:checkin_medicine/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

import '../../data/models/my_medicine_model.dart';

class MyMedicineCard extends StatelessWidget {
  final MyMedicineModel medicine;
  final VoidCallback onDelete;
  final VoidCallback onTap;
  final VoidCallback? onEdit;

  const MyMedicineCard({
    super.key,
    required this.medicine,
    required this.onDelete,
    required this.onTap,
    this.onEdit,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final title = medicine.nickname?.isNotEmpty == true
        ? medicine.nickname!
        : medicine.medicine?.brand ?? '';

    return InkWell(
      borderRadius: BorderRadius.circular(20),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: medicine.canDelete
              ? theme.colorScheme.surface
              : WellnessColors.primary.withOpacity(0.03),
          borderRadius: BorderRadius.circular(20),
          border: Border.all(color: theme.dividerColor.withOpacity(0.08)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            /// TOP ROW
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// ICON
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(14),
                    color: theme.colorScheme.primary.withOpacity(0.08),
                  ),
                  child: Icon(
                    Icons.medication_rounded,
                    color: theme.colorScheme.primary,
                  ),
                ),

                const SizedBox(width: 12),

                /// TITLE + SUBTITLE
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                        ),
                      ),

                      const SizedBox(height: 4),

                      Text(
                        medicine.medicine?.genericName ?? '',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurfaceVariant,
                        ),
                      ),
                      const SizedBox(height: 6),

                      Wrap(
                        spacing: 6,
                        runSpacing: 6,
                        children: [
                          if (!medicine.canDelete)
                            Container(
                              margin: const EdgeInsets.only(right: 8),
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.orange.withOpacity(0.12),
                                borderRadius: BorderRadius.circular(999),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  Icon(
                                    Icons.lock_outline,
                                    size: 14,
                                    color: Colors.orange.shade700,
                                  ),

                                  const SizedBox(width: 4),

                                  Text(
                                    "In Timeline",
                                    style: TextStyle(
                                      fontSize: 11,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.orange.shade700,
                                    ),
                                  ),
                                ],
                              ),
                            ),

                          if (medicine.notes != null)
                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 8,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: Colors.green.withOpacity(0.08),
                                borderRadius: BorderRadius.circular(999),
                              ),
                              child: Text(
                                "${medicine.notes}",
                                style: const TextStyle(
                                  fontSize: 11,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ),
                        ],
                      ),
                    ],
                  ),
                ),

                /// ACTIONS
                Row(
                  children: [
                    if (onEdit != null)
                      IconButton(
                        constraints: const BoxConstraints(),
                        padding: EdgeInsets.zero,
                        onPressed: onEdit,
                        icon: const Icon(Icons.edit_outlined),
                      ),

                    IconButton(
                      constraints: const BoxConstraints(),
                      padding: EdgeInsets.zero,
                      onPressed: medicine.canDelete ? onDelete : null,
                      icon: Icon(
                        medicine.canDelete
                            ? Icons.delete_outline
                            : Icons.lock_outline,
                      ),
                      color: medicine.canDelete
                          ? WellnessColors.error
                          : Colors.grey,
                    ),
                  ],
                ),
              ],
            ),

            // if (medicine.notes?.isNotEmpty == true) ...[
            //   const SizedBox(height: 10),

            //   Container(
            //     width: double.infinity,
            //     padding: const EdgeInsets.symmetric(
            //       horizontal: 10,
            //       vertical: 8,
            //     ),
            //     decoration: BoxDecoration(
            //       color: theme.colorScheme.primary.withOpacity(0.06),
            //       borderRadius: BorderRadius.circular(12),
            //     ),
            //     child: Text(
            //       title,
            //       maxLines: 2,
            //       overflow: TextOverflow.visible,
            //       style: theme.textTheme.titleMedium?.copyWith(
            //         fontWeight: FontWeight.w700,
            //         height: 1.2,
            //       ),
            //     ),
            //   ),
            // ],
          ],
        ),
      ),
    );
  }
}
