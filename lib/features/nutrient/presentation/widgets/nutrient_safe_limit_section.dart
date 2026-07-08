import 'package:checkin_medicine/features/nutrient/data/models/nutrient_safe_limit_model.dart';
import 'package:flutter/material.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../l10n/app_localizations.dart';
import '../../../../core/utils/bumber_formatter.dart';
import '../../data/models/nutrient_model.dart';
import 'package:url_launcher/url_launcher.dart';
class NutrientSafeLimitSection extends StatelessWidget {
  final NutrientModel nutrient;

  const NutrientSafeLimitSection({super.key, required this.nutrient});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    final grouped = <String, List<NutrientSafeLimitModel>>{};

    for (final item in nutrient.safeLimits) {
      grouped.putIfAbsent(item.groupKind, () => []);

      grouped[item.groupKind]!.add(item);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        Text(
          t.safeDosageByGroup,
          style: Theme.of(context).textTheme.titleLarge,
        ),

        const SizedBox(height: 12),

        if (nutrient.safeLimits.isEmpty)
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.surface,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Text(t.noData),
          )
        else
          Column(
            children: grouped.entries
                .map(
                  (entry) => _GroupCard(
                    title: _groupLabel(entry.key, t),
                    items: entry.value,
                    nutrient: nutrient,
                  ),
                )
                .toList(),
          ),
      ],
    );
  }

  static String _groupLabel(String value, AppLocalizations t) {
    switch (value.toLowerCase()) {
      case 'senior':
        return t.senior;

      case 'adult':
        return t.adult;

      case 'pregnant':
        return t.pregnant;

      case 'child':
        return t.child;

      case 'female':
        return t.female;

      case 'male':
        return t.male;
      case 'lactation':
        return t.lactation;

      default:
        return value;
    }
  }
}

class _GroupCard extends StatelessWidget {
  final String title;
  final List<NutrientSafeLimitModel> items;
  final NutrientModel nutrient;

  const _GroupCard({
    required this.title,
    required this.items,
    required this.nutrient,
  });

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return Container(
      margin: const EdgeInsets.only(bottom: 16),

      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
      ),

      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),

            decoration: BoxDecoration(
              color: WellnessColors.primary.withOpacity(.08),

              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(20),
              ),
            ),

            child: Row(
              children: [
                const Icon(
                  Icons.shield_outlined,
                  color: WellnessColors.primary,
                ),

                const SizedBox(width: 8),

                Expanded(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          ),

          ...items.map(
            (item) => Container(
              padding: const EdgeInsets.all(16),

              decoration: BoxDecoration(
                border: Border(
                  bottom: BorderSide(color: Colors.grey.withOpacity(.12)),
                ),
              ),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(bottom: 4),
                    child: Text(
                      _ageRangeText(item, t),
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      if ((item.sourceName ?? '').isNotEmpty)
                        Expanded(
                          child: Text(
                            item.sourceName!,
                            style: const TextStyle(
                              fontWeight: FontWeight.w500,
                            ),
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),

                      if ((item.sourceUrl ?? '').isNotEmpty) ...[
                        const SizedBox(width: 8),

                        TextButton.icon(
                          onPressed: () async {
                            final uri = Uri.tryParse(item.sourceUrl!);
                            if (uri == null) return;

                            await launchUrl(
                              uri,
                              mode: LaunchMode.externalApplication,
                            );
                          },
                          icon: const Icon(Icons.open_in_new, size: 18),
                          label:  Text(t.source),
                          style: TextButton.styleFrom(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            visualDensity: VisualDensity.compact,
                          ),
                        ),
                      ],
                    ],
                  ),
                  if (item.rdaMin != null || item.rdaMax != null)
                    _InfoRow(
                      label: t.rda,
                      value:
                          '${_value(item.rdaMin)} - ${_value(item.rdaMax)} ${nutrient.unit}',
                    ),

                  if (item.odaMin != null || item.odaMax != null)
                    _InfoRow(
                      label: t.oda,
                      value:
                          '${_value(item.odaMin)} - ${_value(item.odaMax)} ${nutrient.unit}',
                    ),

                  if (item.ulMax != null)
                    _InfoRow(
                      label: t.ul,
                      value:
                          '≤ ${NumberFormatter.withUnit(item.ulMax, nutrient.unit)}',
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  static String _value(double? value) {
    if (value == null) return '-';

    if (value % 1 == 0) {
      return value.toInt().toString();
    }

    return value.toString();
  }

  static String _ageRangeText(NutrientSafeLimitModel item, AppLocalizations t) {
    if (item.ageMinMonths == null || item.ageMaxMonths == null) {
      return '';
    }

    final min = item.ageMinMonths!;
    final max = item.ageMaxMonths!;

    if (max < 12) {
      return '$min-$max ${t.months}';
    }

    final minYear = min / 12;
    final maxYear = max / 12;

    return '${minYear.toStringAsFixed(0)}-${maxYear.toStringAsFixed(0)} ${t.yearsOld}';
  }
}

class _InfoRow extends StatelessWidget {
  final String label;
  final String value;

  const _InfoRow({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text(label, style: const TextStyle(fontWeight: FontWeight.w600)),

          Expanded(child: Text(value, textAlign: TextAlign.right)),
        ],
      ),
    );
  }
}
