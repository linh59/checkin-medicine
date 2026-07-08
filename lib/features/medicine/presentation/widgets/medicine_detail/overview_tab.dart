import 'package:checkin_medicine/core/extension/medicine_form_extension.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../core/utils/bumber_formatter.dart';
import '../../../../../l10n/app_localizations.dart';
import '../../../data/models/medicine_detail_model.dart';

class OverviewTab extends StatelessWidget {
  final Medicine medicine;

  const OverviewTab({
    super.key,
    required this.medicine,
  });

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    final colorScheme = Theme.of(context).colorScheme;

    final hasServingData = medicine.ingredients.any(
          (e) => (e.amountPerServing ?? 0) > 0,
    );

    final servingText =
        '${t.basedOn} ${hasServingData ? medicine.pillsPerServing ?? 1 : 1} ${medicine.form.localized(t)}';

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// SUMMARY
          if ((medicine.summary ?? '').isNotEmpty)
            _OverviewCard(
              title: t.summary,
              icon: Icons.summarize_outlined,
              child: Text(
                medicine.summary!,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  height: 1.75,
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ),

          if ((medicine.summary ?? '').isNotEmpty)
            const SizedBox(height: 20),

          /// DESCRIPTION
          if ((medicine.description ?? '').isNotEmpty)
            _OverviewCard(
              title: t.description,
              icon: Icons.description_outlined,
              child: Text(
                medicine.description!,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  height: 1.75,
                  color: colorScheme.onSurfaceVariant,
                ),
              ),
            ),

          /// INGREDIENTS
          _OverviewCard(
            title: t.ingredientSummary,
            subtitle: servingText,
            icon: Icons.science_outlined,
            child: Column(
              children: medicine.ingredients.asMap().entries.map((entry) {
                final index = entry.key;
                final item = entry.value;

                final isLast =
                    index == medicine.ingredients.length - 1;

                final formText = item.forms
                    .map((e) => e.saltForm ?? e.name)
                    .whereType<String>()
                    .where((e) => e.trim().isNotEmpty)
                    .join(', ');

                return Column(
                  children: [
                    Padding(
                      padding:
                      const EdgeInsets.symmetric(vertical: 12),
                      child: Row(
                        crossAxisAlignment:
                        CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Column(
                              crossAxisAlignment:
                              CrossAxisAlignment.start,
                              children: [
                                Text(
                                  item.nutrient?.name ?? '-',
                                  style: Theme.of(context)
                                      .textTheme
                                      .titleSmall
                                      ?.copyWith(
                                    fontWeight:
                                    FontWeight.w700,
                                  ),
                                ),

                                if (formText.isNotEmpty)
                                  Padding(
                                    padding:
                                    const EdgeInsets.only(
                                        top: 4),
                                    child: Text(
                                      '(as $formText)',
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(
                                        color: colorScheme
                                            .onSurfaceVariant,
                                      ),
                                    ),
                                  ),
                              ],
                            ),
                          ),

                          const SizedBox(width: 12),

                          if ((item.amountPerServing ?? 0) > 0)
                            Text(
                              NumberFormatter.dosage(
                                amount:
                                item.amountPerServing,
                                unit: item.unit

                              ),
                              textAlign: TextAlign.end,
                              style: Theme.of(context)
                                  .textTheme
                                  .labelLarge
                                  ?.copyWith(
                                fontWeight:
                                FontWeight.w700,
                              ),
                            ),
                        ],
                      ),
                    ),

                    if (!isLast)
                      Divider(
                        height: 1,
                        color: colorScheme.outlineVariant,
                      ),
                  ],
                );
              }).toList(),
            ),
          ),

          /// SOURCE
          if ((medicine.sourceName ?? '').isNotEmpty ||
              (medicine.sourceUrl ?? '').isNotEmpty)
            _OverviewCard(
              title: t.sourceName,
              icon: Icons.link_outlined,
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  if ((medicine.sourceName ?? '').isNotEmpty)
                    Text(
                      medicine.sourceName!,
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall
                          ?.copyWith(
                        fontWeight:
                        FontWeight.w600,
                      ),
                    ),

                  if ((medicine.sourceUrl ?? '').isNotEmpty) ...[
                    const SizedBox(height: 8),

                    TextButton.icon(
                      style: TextButton.styleFrom(
                        padding: EdgeInsets.zero,
                        alignment:
                        Alignment.centerLeft,
                      ),
                      onPressed: () async {
                        final uri = Uri.tryParse(
                          medicine.sourceUrl!,
                        );

                        if (uri != null) {
                          await launchUrl(
                            uri,
                            mode: LaunchMode
                                .externalApplication,
                          );
                        }
                      },
                      icon: const Icon(
                        Icons.open_in_new,
                        size: 18,
                      ),
                      label: Flexible(
                        child: Text(
                          medicine.sourceUrl!,
                          overflow:
                          TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),

          const SizedBox(height: 24),
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
      margin: const EdgeInsets.only(bottom: 20),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment:
        CrossAxisAlignment.start,
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
                    fontWeight:
                    FontWeight.w700,
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
                color:
                colorScheme.onSurfaceVariant,
              ),
            ),
          ],

          const SizedBox(height: 16),

          child,
        ],
      ),
    );
  }
}