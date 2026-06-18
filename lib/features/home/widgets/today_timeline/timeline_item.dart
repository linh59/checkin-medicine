import 'package:checkin_medicine/features/home/data/models/today_timeline_item_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:checkin_medicine/core/theme/app_colors.dart';
import 'package:checkin_medicine/features/home/presentation/providers/today_action_provider.dart';
import 'package:checkin_medicine/l10n/app_localizations.dart';

class TimelineItem extends ConsumerWidget {
  final TodayTimelineItem item;
  final String scheduleTime;
  final bool isLast;

  const TimelineItem({
    super.key,
    required this.item,
    required this.scheduleTime,
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

    final action = ref.read(
      todayActionProvider.notifier,
    );

    final isTablet =
        MediaQuery.of(context).size.width > 700;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment:
        CrossAxisAlignment.start,
        children: [
          /// LEFT TIMELINE
          SizedBox(
            width: isTablet ? 90 : 70,
            child: Column(
              children: [
                Text(
                  scheduleTime.substring(0, 5),
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
                    color: item.taken
                        ? Colors.green
                        : WellnessColors.primary,
                  ),
                  child: item.taken
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
                bottom: 16,
              ),
              padding:
              const EdgeInsets.all(16),
              decoration: BoxDecoration(
                borderRadius:
                BorderRadius.circular(
                  20,
                ),
                color: item.taken
                    ? Colors.green
                    .withOpacity(.05)
                    : Colors.white,
                border: Border.all(
                  color: item.taken
                      ? Colors.green
                      .withOpacity(.25)
                      : WellnessColors.border,
                ),
              ),
              child: Column(
                crossAxisAlignment:
                CrossAxisAlignment.start,
                children: [
                  /// TOP BAR
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          item.planName ?? '',
                          overflow:
                          TextOverflow
                              .ellipsis,
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors
                                .grey.shade600,
                            fontWeight:
                            FontWeight
                                .w600,
                          ),
                        ),
                      ),

                      _ActionButton(
                        item: item,
                        onTap: () async {
                          if (item.taken) {
                            await action
                                .undoTaken(
                              scheduleId:
                              item.scheduleId,
                            );
                          } else {
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
                    ],
                  ),

                  const SizedBox(height: 12),

                  Text(
                    item.medicineName,
                    style: TextStyle(
                      fontSize:
                      isTablet ? 18 : 16,
                      fontWeight:
                      FontWeight.w800,
                    ),
                  ),

                  const SizedBox(height: 8),

                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: [
                      Chip(
                        label: Text(
                          "${item.dose} ${t.pills}",
                        ),
                      ),

                      if (item.nickname
                          .isNotEmpty)
                        Chip(
                          label: Text(
                            item.nickname,
                          ),
                        ),
                    ],
                  ),

                  if ((item.withFood ?? '')
                      .isNotEmpty)
                    Padding(
                      padding:
                      const EdgeInsets.only(
                        top: 8,
                      ),
                      child: Text(
                        item.withFood!,
                      ),
                    ),

                  if ((item.notes ?? '')
                      .isNotEmpty)
                    Padding(
                      padding:
                      const EdgeInsets.only(
                        top: 8,
                      ),
                      child: Text(
                        "📝 ${item.notes}",
                      ),
                    ),

                  if (item.taken &&
                      item.takenAt != null)
                    Padding(
                      padding:
                      const EdgeInsets.only(
                        top: 12,
                      ),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.check_circle,
                            color: Colors.green,
                            size: 18,
                          ),
                          const SizedBox(
                              width: 6),
                          Text(
                            t.takenAt(
                              _formatTime(
                                item.takenAt!,
                              ),
                            ),
                            style:
                            const TextStyle(
                              color:
                              Colors.green,
                              fontWeight:
                              FontWeight
                                  .w600,
                            ),
                          ),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _ActionButton extends StatelessWidget {
  final VoidCallback onTap;
  final dynamic item;

  const _ActionButton({
    required this.onTap,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return InkWell(
      onTap: onTap,
      borderRadius:
      BorderRadius.circular(999),
      child: Container(
        padding:
        const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 8,
        ),
        decoration: BoxDecoration(
          borderRadius:
          BorderRadius.circular(999),
          color: item.taken
              ? Colors.green
              .withOpacity(.1)
              : WellnessColors.primary
              .withOpacity(.1),
        ),
        child: Text(
          item.taken
              ? t.undoTaken
              : t.markTaken,
          style: TextStyle(
            fontWeight: FontWeight.w600,
            color: item.taken
                ? Colors.green
                : WellnessColors.primary,
          ),
        ),
      ),
    );
  }
}