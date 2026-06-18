import 'package:checkin_medicine/features/home/widgets/today_timeline/timeline_group_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:checkin_medicine/features/home/presentation/providers/today_provider.dart';
import 'package:checkin_medicine/l10n/app_localizations.dart';


class TodayList extends ConsumerWidget {
  const TodayList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = AppLocalizations.of(context)!;

    final timeline = ref.watch(todayTimelineProvider);

    return timeline.when(
      loading: () => const Center(
        child: Padding(
          padding: EdgeInsets.all(24),
          child: CircularProgressIndicator(),
        ),
      ),

      error: (e, _) => Padding(
        padding: const EdgeInsets.all(16),
        child: Text(e.toString()),
      ),

      data: (groups) {
        if (groups.isEmpty) {
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Center(
                child: Text(t.noData),
              ),
            ),
          );
        }

        final totalMedicines = groups.fold<int>(
          0,
              (sum, g) => sum + g.items.length,
        );

        final takenMedicines = groups.fold<int>(
          0,
              (sum, g) => sum + g.items.where((e) => e.taken).length,
        );

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              t.todayCheckin,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge
                  ?.copyWith(
                fontWeight: FontWeight.w800,
              ),
            ),

            const SizedBox(height: 12),

            LinearProgressIndicator(
              value: totalMedicines == 0
                  ? 0
                  : takenMedicines / totalMedicines,
              minHeight: 8,
              borderRadius: BorderRadius.circular(999),
            ),

            const SizedBox(height: 8),

            Text(
              "$takenMedicines / $totalMedicines",
              style: Theme.of(context).textTheme.bodySmall,
            ),

            const SizedBox(height: 24),

            ...groups.asMap().entries.map(
                  (entry) {
                return TimelineGroupCard(
                  group: entry.value,
                  isLast: entry.key == groups.length - 1,
                );
              },
            ),
          ],
        );
      },
    );
  }
}