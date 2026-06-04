import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:checkin_medicine/core/theme/app_colors.dart';
import 'package:checkin_medicine/features/home/presentation/providers/today_action_provider.dart';
import 'package:checkin_medicine/features/home/presentation/providers/today_provider.dart';
import 'package:checkin_medicine/l10n/app_localizations.dart';

class TodayList extends ConsumerWidget {
  const TodayList({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = AppLocalizations.of(context)!;
    final timeline = ref.watch(todayTimelineProvider);

    return timeline.when(
      loading: () => const Center(child: CircularProgressIndicator()),
      error: (e, _) =>
          Padding(padding: const EdgeInsets.all(16), child: Text(e.toString())),
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
            /// HEADER
            Text(
              t.todayCheckin,
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800),
            ),
            const SizedBox(height: 14),

            ...groups.map((group) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  /// TIME CHIP
                  Container(
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    // decoration: BoxDecoration(
                    //   color: WellnessColors.border.withOpacity(0.5),
                    //   borderRadius: BorderRadius.circular(999),
                    // ),
                    child: Text(
                      group.time.substring(0, 5),

                      style: const TextStyle(
                        fontWeight: FontWeight.w700,
                        fontSize: 17,
                      ),
                    ),
                  ),

                  ...group.items.map((item) {
                    final action = ref.read(todayActionProvider.notifier);

                    return Container(
                      margin: const EdgeInsets.only(bottom: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(14),

                        color: item.taken
                            ? WellnessColors.primary.withOpacity(0.1)
                            : Colors.transparent,
                        border: Border.all(
                          width: 2,
                          color: item.taken
                              ? WellnessColors.primary
                              : WellnessColors.border,
                        ),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 10,
                              ),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  /// PLAN NAME
                                  Text(
                                    item.planName ?? '',
                                    style: const TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(height: 4),

                                  /// MEDICINE NAME
                                  Text(
                                    item.medicineName,
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),

                                  if (item.nickname.isNotEmpty)
                                    Padding(
                                      padding: const EdgeInsets.only(top: 2),
                                      child: Text(
                                        item.nickname,
                                        style: TextStyle(
                                          fontSize: 12,
                                          color: Theme.of(
                                            context,
                                          ).colorScheme.primary,
                                          fontWeight: FontWeight.w600,
                                        ),
                                      ),
                                    ),

                                  const SizedBox(height: 6),

                                  /// DOSE + FOOD
                                  Text(
                                    '${item.dose} ${t.pills}',
                                    style: const TextStyle(fontSize: 15),
                                  ),

                                  Text(
                                    '${(item.withFood ?? '').isNotEmpty ? "${item.withFood}" : ""}',
                                    style: const TextStyle(fontSize: 14),
                                  ),
                                  if ((item.notes ?? '').isNotEmpty)
                                    Padding(
                                      padding: const EdgeInsets.only(top: 4),
                                      child: Text(
                                        '📝 ${item.notes}',
                                        style: const TextStyle(fontSize: 11),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ),

                          /// ACTION BUTTON
                          Padding(
                            padding: const EdgeInsets.only(right: 10, top: 10),
                            child: InkWell(
                              onTap: () async {
                                if (item.taken) {
                                  await action.undoTaken(
                                    scheduleId: item.scheduleId,
                                  );
                                } else {
                                  await action.markAsTaken(
                                    scheduleId: item.scheduleId,
                                    myMedicineId: item.myMedicineId,
                                  );
                                }
                              },
                              borderRadius: BorderRadius.circular(999),
                              child: Container(
                                padding: const EdgeInsets.all(9),
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: item.taken
                                      ? Colors.transparent
                                      : WellnessColors.primary.withOpacity(
                                          0.12,
                                        ),
                                ),
                                child: Icon(
                                  item.taken ? Icons.undo : Icons.check,
                                  size: 18,
                                  color: item.taken
                                      ? Colors.green
                                      : WellnessColors.primary,
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  }),

                  const SizedBox(height: 14),
                ],
              );
            }),
          ],
        );
      },
    );
  }
}
