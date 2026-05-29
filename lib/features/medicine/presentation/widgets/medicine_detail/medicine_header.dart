import 'package:flutter/material.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../data/models/medicine_detail_model.dart';

class MedicineHeader extends StatelessWidget {
  final Medicine medicine;
  final String? notes;

  const MedicineHeader({super.key, required this.medicine, this.notes});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final imageUrl = medicine.imageUrl; // giả sử model có field này

    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 30),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: theme.dividerColor.withOpacity(0.08)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// TOP ROW (IMAGE + INFO)
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              /// IMAGE (ENHANCED)
              Container(
                width: 86,
                height: 86,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  color: theme.colorScheme.primary.withOpacity(0.08),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                clipBehavior: Clip.antiAlias,
                child: imageUrl != null && imageUrl.isNotEmpty
                    ? Image.network(
                        imageUrl,
                        fit: BoxFit.cover,
                        errorBuilder: (_, __, ___) {
                          return const Icon(
                            Icons.medication,
                            size: 40,
                            color: WellnessColors.primary,
                          );
                        },
                      )
                    : const Icon(
                        Icons.medication,
                        size: 40,
                        color: WellnessColors.primary,
                      ),
              ),

              const SizedBox(width: 14),

              /// TEXT INFO
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      medicine.brand,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.titleLarge?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),

                    if (medicine.genericName != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 6),
                        child: Text(
                          medicine.genericName!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ),

                    const SizedBox(height: 10),

                    Wrap(
                      spacing: 8,
                      runSpacing: 8,
                      children: [
                        if (medicine.servingSize != null)
                          Chip(
                            label: Text(medicine.servingSize!),
                            visualDensity: VisualDensity.compact,
                          ),
                      ],
                    ),

                    if (medicine.manufacturer != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 8),
                        child: Text(
                          medicine.manufacturer!,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: theme.colorScheme.onSurfaceVariant,
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),

          /// NOTES SECTION
          if (notes != null && notes!.isNotEmpty) ...[
            const SizedBox(height: 14),

            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withOpacity(0.06),
                borderRadius: BorderRadius.circular(14),
              ),
              child: Text(
                notes!,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                  height: 1.4,
                ),
              ),
            ),
          ],
        ],
      ),
    );
  }
}
