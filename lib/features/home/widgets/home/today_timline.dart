import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:checkin_medicine/core/theme/app_colors.dart';
import 'package:checkin_medicine/features/home/presentation/providers/today_action_provider.dart';
import 'package:checkin_medicine/features/home/presentation/providers/today_provider.dart';
import 'package:checkin_medicine/l10n/app_localizations.dart';

class TodayList extends ConsumerWidget {
  const TodayList({super.key});

  String _formatTime(DateTime time) {
    final h = time.hour.toString().padLeft(2, '0');
    final m = time.minute.toString().padLeft(2, '0');
    return '$h:$m';
  }

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
            const SizedBox(height: 16),

            ...groups.map((group) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: Text(
                      group.time.substring(0, 5),
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w700,
                        color: Colors.grey.shade700,
                      ),
                    ),
                  ),

                  ...group.items.map((item) {
                    final action = ref.read(todayActionProvider.notifier);

                    return Container(
                      margin: const EdgeInsets.only(bottom: 12),
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        color: item.taken
                            ? Colors.green.withOpacity(0.06)
                            : Colors.white,
                        border: Border.all(
                          color: item.taken
                              ? Colors.green.withOpacity(0.25)
                              : WellnessColors.border.withOpacity(0.6),
                          width: 1.2,
                        ),
                      ),

                      /// CARD CONTENT
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /// TOP ROW: PLAN + TIME + ACTION
                          Row(
                            children: [
                              /// PLAN NAME
                              if ((item.planName ?? '').isNotEmpty)
                                Expanded(
                                  child: Text(
                                    item.planName!,
                                    overflow: TextOverflow.ellipsis,
                                    style: TextStyle(
                                      fontSize: 12,
                                      color: Colors.grey.shade600,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                )
                              else
                                const Spacer(),

                              /// TAKEN TIME / SCHEDULE TIME
                              if (item.taken && item.takenAt != null)
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 4,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Colors.green.withOpacity(0.12),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    t.takenAt(_formatTime(item.takenAt!)),
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: Colors.green.shade700,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                )
                              else
                                Text(
                                  group.time.substring(0, 5),
                                  style: TextStyle(
                                    fontSize: 12,
                                    color: Colors.grey.shade600,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),

                              const SizedBox(width: 10),

                              /// ACTION BUTTON (APPLE HEALTH STYLE)
                              InkWell(
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
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 6,
                                  ),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(999),
                                    color: item.taken
                                        ? Colors.green.withOpacity(0.12)
                                        : WellnessColors.primary.withOpacity(
                                            0.12,
                                          ),
                                    border: Border.all(
                                      color: item.taken
                                          ? Colors.green.withOpacity(0.35)
                                          : WellnessColors.primary.withOpacity(
                                              0.25,
                                            ),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Icon(
                                        item.taken
                                            ? Icons.check_circle
                                            : Icons.add_circle,
                                        size: 16,
                                        color: item.taken
                                            ? Colors.green
                                            : WellnessColors.primary,
                                      ),
                                      const SizedBox(width: 6),
                                      Text(
                                        item.taken ? t.undoTaken : t.markTaken,
                                        style: TextStyle(
                                          fontSize: 12,
                                          fontWeight: FontWeight.w600,
                                          color: item.taken
                                              ? Colors.green
                                              : WellnessColors.primary,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),

                          const SizedBox(height: 10),

                          /// MEDICINE NAME
                          Text(
                            item.medicineName,
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w800,
                            ),
                          ),

                          const SizedBox(height: 6),

                          /// DOSE + NICKNAME
                          Row(
                            children: [
                              Text(
                                '${item.dose} ${t.pills}',
                                style: TextStyle(
                                  fontSize: 13,
                                  color: Colors.grey.shade700,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),

                              const SizedBox(width: 10),

                              if (item.nickname.isNotEmpty)
                                Container(
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 8,
                                    vertical: 3,
                                  ),
                                  decoration: BoxDecoration(
                                    color: Theme.of(
                                      context,
                                    ).colorScheme.primary.withOpacity(0.08),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Text(
                                    item.nickname,
                                    style: TextStyle(
                                      fontSize: 11,
                                      color: Theme.of(
                                        context,
                                      ).colorScheme.primary,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                            ],
                          ),

                          const SizedBox(height: 6),

                          /// FOOD
                          if ((item.withFood ?? '').isNotEmpty)
                            Text(
                              item.withFood!,
                              style: TextStyle(
                                fontSize: 12,
                                color: Colors.grey.shade600,
                              ),
                            ),

                          /// NOTES
                          if ((item.notes ?? '').isNotEmpty)
                            Padding(
                              padding: const EdgeInsets.only(top: 4),
                              child: Text(
                                '📝 ${item.notes}',
                                style: TextStyle(
                                  fontSize: 11,
                                  color: Colors.grey.shade600,
                                ),
                              ),
                            ),
                        ],
                      ),
                    );
                  }),

                  const SizedBox(height: 16),
                ],
              );
            }),
          ],
        );
      },
    );
  }
}
