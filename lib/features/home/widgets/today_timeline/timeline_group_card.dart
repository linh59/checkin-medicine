import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:checkin_medicine/core/theme/app_colors.dart';
import 'package:checkin_medicine/features/home/data/models/today_timeline_group_model.dart';
import 'package:checkin_medicine/features/home/data/models/today_timeline_item_model.dart';
import 'package:checkin_medicine/features/home/presentation/providers/today_action_provider.dart';
import 'package:checkin_medicine/l10n/app_localizations.dart';

class TimelineGroupCard extends ConsumerWidget {
  final TodayTimelineGroup group;
  final bool isLast;

  const TimelineGroupCard({
    super.key,
    required this.group,
    required this.isLast,
  });

  String _formatTime(DateTime time) {
    final h = time.hour.toString().padLeft(2, '0');
    final m = time.minute.toString().padLeft(2, '0');

    return '$h:$m';
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = AppLocalizations.of(context)!;

    final items = group.items;

    final allTaken = items.every(
          (TodayTimelineItem item) => item.taken,
    );

    final takenCount = items.where(
          (TodayTimelineItem item) => item.taken,
    ).length;

    final action = ref.read(
      todayActionProvider.notifier,
    );

    final isTablet =
        MediaQuery.sizeOf(context).width >= 700;

    final takenItems = items.where(
          (TodayTimelineItem item) =>
      item.takenAt != null,
    );

    final firstTaken = takenItems.isEmpty
        ? null
        : takenItems.first;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [
          /// TIMELINE
          SizedBox(
            width: isTablet ? 90 : 70,
            child: Column(
              children: [
                Text(
                  group.time.substring(0, 5),
                  style: TextStyle(
                    fontSize:
                    isTablet ? 14 : 12,
                    fontWeight:
                    FontWeight.w700,
                  ),
                ),

                const SizedBox(height: 8),

                Container(
                  width: 18,
                  height: 18,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: allTaken
                        ? Colors.green
                        : WellnessColors.primary,
                  ),
                  child: allTaken
                      ? const Icon(
                    Icons.check,
                    size: 12,
                    color: Colors.white,
                  )
                      : null,
                ),

                if (!isLast)
                  Expanded(
                    child: Container(
                      width: 2,
                      margin:
                      const EdgeInsets.only(
                        top: 4,
                      ),
                      color:
                      Colors.grey.shade300,
                    ),
                  ),
              ],
            ),
          ),

          /// CARD
          Expanded(
            child: Container(
              margin:
              const EdgeInsets.only(
                bottom: 20,
              ),
              padding:
              const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: allTaken
                    ? Colors.green
                    .withValues(alpha: .05)
                    : Colors.white,
                borderRadius:
                BorderRadius.circular(20),
                border: Border.all(
                  color: allTaken
                      ? Colors.green
                      .withValues(alpha: .25)
                      : WellnessColors.border,
                ),
              ),
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  /// HEADER
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          '${items.length} ${t.medicines}',
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight:
                            FontWeight.w600,
                            color: Colors
                                .grey.shade600,
                          ),
                        ),
                      ),

                      Container(
                        padding:
                        const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 5,
                        ),
                        decoration:
                        BoxDecoration(
                          color:
                          WellnessColors.primary
                              .withValues(
                            alpha: .08,
                          ),
                          borderRadius:
                          BorderRadius.circular(
                            999,
                          ),
                        ),
                        child: Text(
                          '$takenCount/${items.length}',
                          style:
                          const TextStyle(
                            fontSize: 12,
                            fontWeight:
                            FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  /// MEDICINES
                  ...items.map(
                        (
                        TodayTimelineItem item,
                        ) {
                      return Padding(
                        padding:
                        const EdgeInsets.only(
                          bottom: 14,
                        ),
                        child: Row(
                          crossAxisAlignment:
                          CrossAxisAlignment
                              .start,
                          children: [
                            Icon(
                              item.taken
                                  ? Icons
                                  .check_circle
                                  : Icons
                                  .radio_button_unchecked,
                              size: 18,
                              color: item.taken
                                  ? Colors.green
                                  : Colors.grey,
                            ),

                            const SizedBox(
                              width: 10,
                            ),

                            Expanded(
                              child: Column(
                                crossAxisAlignment:
                                CrossAxisAlignment
                                    .start,
                                children: [
                                  Text(
                                    item.medicineName,
                                    style:
                                    const TextStyle(
                                      fontWeight:
                                      FontWeight
                                          .w700,
                                      fontSize: 15,
                                    ),
                                  ),

                                  const SizedBox(
                                    height: 2,
                                  ),

                                  Text(
                                    '${item.dose} ${t.pills}',
                                    style:
                                    TextStyle(
                                      fontSize:
                                      12,
                                      color: Colors
                                          .grey
                                          .shade600,
                                    ),
                                  ),

                                  if (item.nickname
                                      .isNotEmpty)
                                    Padding(
                                      padding:
                                      const EdgeInsets.only(
                                        top: 4,
                                      ),
                                      child: Text(
                                        item.nickname,
                                        style:
                                        TextStyle(
                                          fontSize:
                                          11,
                                          color: Colors
                                              .grey
                                              .shade500,
                                        ),
                                      ),
                                    ),

                                  if ((item.withFood ??
                                      '')
                                      .isNotEmpty)
                                    Padding(
                                      padding:
                                      const EdgeInsets.only(
                                        top: 4,
                                      ),
                                      child: Text(
                                        item.withFood!,
                                        style:
                                        TextStyle(
                                          fontSize:
                                          11,
                                          color: Colors
                                              .grey
                                              .shade600,
                                        ),
                                      ),
                                    ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),

                  if (allTaken &&
                      firstTaken != null)
                    Container(
                      margin:
                      const EdgeInsets.only(
                        top: 4,
                      ),
                      padding:
                      const EdgeInsets.all(
                        12,
                      ),
                      decoration: BoxDecoration(
                        color: Colors.green
                            .withValues(
                          alpha: .08,
                        ),
                        borderRadius:
                        BorderRadius.circular(
                          12,
                        ),
                      ),
                      child: Row(
                        children: [

                          Text(
                            t.takenAt(
                              _formatTime(
                                firstTaken
                                    .takenAt!,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                  if (!allTaken) ...[
                    const SizedBox(height: 12),

                    SizedBox(
                      width: double.infinity,
                      child: FilledButton.icon(
                        icon: const Icon(
                          Icons.check,
                        ),
                        label: Text(
                          t.markTaken,
                        ),
                        onPressed: () async {
                          for (final item
                          in items.where(
                                (
                                TodayTimelineItem e,
                                ) =>
                            !e.taken,
                          )) {
                            await action
                                .markAsTaken(
                              scheduleId:
                              item.scheduleId,
                              myMedicineId:
                              item.myMedicineId,
                              dose: item.dose,
                            );
                          }
                        },
                      ),
                    ),
                  ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}