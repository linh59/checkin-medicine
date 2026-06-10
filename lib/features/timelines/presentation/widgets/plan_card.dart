import 'package:checkin_medicine/features/timelines/presentation/pages/timeline_detail_page.dart';
import 'package:checkin_medicine/features/timelines/presentation/providers/timelines_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/plan_model.dart';
import '../../../../l10n/app_localizations.dart';

class PlanCard extends ConsumerWidget {
  final PlanModel plan;

  const PlanCard({super.key, required this.plan});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final colorScheme = theme.colorScheme;
    final t = AppLocalizations.of(context)!;

    final isActive = plan.isActive;

    return LayoutBuilder(
      builder: (context, constraints) {
        final isTablet = constraints.maxWidth > 600;

        return InkWell(
          borderRadius: BorderRadius.circular(16),

          onTap: () async {
            /// 👉 OPEN DETAIL
            await Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => TimelineDetailPage(timelineId: plan.id),
              ),
            );

            /// AUTO REFRESH LIST WHEN BACK
            ref.invalidate(plansProvider);
          },

          child: Container(
            padding: EdgeInsets.all(isTablet ? 20 : 16),
            margin: const EdgeInsets.only(bottom: 12),
            decoration: BoxDecoration(
              color: isActive
                  ? colorScheme.surface
                  : colorScheme.surfaceContainerHighest,
              borderRadius: BorderRadius.circular(16),
              border: Border.all(
                color: isActive
                    ? colorScheme.primary.withOpacity(0.3)
                    : colorScheme.outlineVariant,
              ),
              boxShadow: [
                BoxShadow(
                  blurRadius: 10,
                  color: Colors.black.withOpacity(0.05),
                ),
              ],
            ),

            child: Row(
              children: [
                Container(
                  width: isTablet ? 52 : 44,
                  height: isTablet ? 52 : 44,
                  decoration: BoxDecoration(
                    color: isActive
                        ? colorScheme.primary.withOpacity(0.1)
                        : colorScheme.surfaceContainerHighest,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Icon(
                    Icons.calendar_month,
                    color: isActive
                        ? colorScheme.primary
                        : colorScheme.onSurfaceVariant,
                  ),
                ),

                const SizedBox(width: 12),

                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        plan.name,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: isActive
                              ? colorScheme.onSurface
                              : colorScheme.onSurfaceVariant,
                        ),
                      ),

                      const SizedBox(height: 4),

                      Text(
                        _buildSubtitle(t),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),
                    ],
                  ),
                ),

                const SizedBox(width: 8),

                Switch(
                  value: isActive,
                  onChanged: (v) {
                    ref.read(plansProvider.notifier).togglePlan(plan.id, v);
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  String _buildSubtitle(AppLocalizations t) {
    final status = plan.isActive ? t.active : t.paused;
    return status;
  }
}
