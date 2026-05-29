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

    return InkWell(
      borderRadius: BorderRadius.circular(24),
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: theme.colorScheme.surface,
          borderRadius: BorderRadius.circular(24),
        ),
        child: Row(
          children: [
            Container(
              width: 52,
              height: 52,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                color: theme.colorScheme.primary
                    .withOpacity(.1),
              ),
              child: Icon(
                Icons.medication_rounded,
                color: theme.colorScheme.primary,
              ),
            ),

            const SizedBox(width: 14),

            Expanded(
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  Text(
                    medicine.nickname?.isNotEmpty ==
                        true
                        ? medicine.nickname!
                        : medicine.medicine?.brand ??
                        '',
                    style: theme.textTheme.titleMedium
                        ?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),

                  const SizedBox(height: 4),

                  Text(
                    medicine.medicine
                        ?.genericName ??
                        '',
                    style:
                    theme.textTheme.bodySmall,
                  ),
                ],
              ),
            ),

            if (onEdit != null)
              IconButton(
                onPressed: onEdit,
                icon: const Icon(Icons.edit),
              ),

            IconButton(
              onPressed: onDelete,
              icon: const Icon(Icons.delete_outline),
            ),

            const Icon(
              Icons.chevron_right_rounded,
            ),
          ],
        ),
      ),
    );
  }
}