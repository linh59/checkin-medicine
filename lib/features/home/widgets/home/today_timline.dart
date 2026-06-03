import 'package:checkin_medicine/core/theme/app_colors.dart';
import 'package:checkin_medicine/features/home/presentation/providers/today_action_provider.dart';
import 'package:checkin_medicine/features/home/presentation/providers/today_provider.dart';
import 'package:checkin_medicine/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TodayList extends ConsumerWidget {
  const TodayList();

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

      error: (e, _) =>
          Padding(padding: const EdgeInsets.all(16), child: Text('Error: $e')),

      data: (groups) {
        if (groups.isEmpty) {
          return Card(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Center(child: Text(t.noData)),
            ),
          );
        }

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              t.todayCheckin,
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 12),

            ...groups.map(
              (group) => Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: WellnessColors.primary.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(999),
                    ),
                    child: Text(
                      group.time,
                      style: const TextStyle(fontWeight: FontWeight.w600),
                    ),
                  ),

                  const SizedBox(height: 10),

                  ...group.items.map(
                    (item) => Card(
                      margin: const EdgeInsets.only(bottom: 10),
                      child: Padding(
                        padding: const EdgeInsets.all(12),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Icon(
                              item.taken
                                  ? Icons.check_circle
                                  : Icons.radio_button_unchecked,
                              color: item.taken ? Colors.green : Colors.grey,
                            ),

                            const SizedBox(width: 12),

                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.medicineName,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),

                                  if (item.nickname.isNotEmpty)
                                    Padding(
                                      padding: const EdgeInsets.only(top: 4),
                                      child: Text(item.nickname),
                                    ),

                                  const SizedBox(height: 6),

                                  Text('Dose: ${item.dose}'),

                                  if ((item.withFood ?? '').isNotEmpty)
                                    Padding(
                                      padding: const EdgeInsets.only(top: 4),
                                      child: Text('🍽 ${item.withFood}'),
                                    ),

                                  if ((item.notes ?? '').isNotEmpty)
                                    Padding(
                                      padding: const EdgeInsets.only(top: 4),
                                      child: Text('📝 ${item.notes}'),
                                    ),
                                ],
                              ),
                            ),

                            IconButton(
                              onPressed: () async {
                                final action = ref.read(todayActionProvider);

                                if (item.taken) {
                                  await action.undoTaken(item.scheduleId);
                                } else {
                                  await action.markAsTaken(
                                    scheduleId: item.scheduleId,
                                    myMedicineId: item.myMedicineId,
                                  );
                                }
                              },
                              icon: Icon(item.taken ? Icons.undo : Icons.check),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(height: 16),
                ],
              ),
            ),
          ],
        );
      },
    );
  }
}
