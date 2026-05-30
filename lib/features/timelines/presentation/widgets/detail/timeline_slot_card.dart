import 'package:checkin_medicine/core/theme/app_colors.dart';
import 'package:checkin_medicine/features/timelines/data/models/timeline_slot_model.dart';
import 'package:checkin_medicine/features/timelines/presentation/providers/timeline_detail_provider.dart';
import 'package:checkin_medicine/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TimelineSlotCard extends ConsumerWidget {
  final TimelineSlotModel slot;
  final bool isLast;
  final VoidCallback onTap;

  const TimelineSlotCard({
    super.key,
    required this.slot,
    required this.isLast,
    required this.onTap,
  });

  String _foodLabel(BuildContext context, String? value) {
    final t = AppLocalizations.of(context)!;

    switch (value) {
      case 'before':
        return t.beforeMeal;
      case 'after':
        return t.afterMeal;
      case 'with':
        return t.withMeal;
      default:
        return '';
    }
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = AppLocalizations.of(context)!;
    final repository = ref.read(timelineRepositoryProvider);

    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    final screenWidth = MediaQuery.sizeOf(context).width;
    final isTablet = screenWidth >= 768;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// TIME (FIXED - NO WRAP)
          SizedBox(
            width: isTablet ? 64 : 54,
            child: FittedBox(
              fit: BoxFit.scaleDown,
              alignment: Alignment.centerLeft,
              child: Text(
                slot.time,
                maxLines: 1,
                softWrap: false,
                overflow: TextOverflow.clip,
                style: TextStyle(
                  fontSize: isTablet ? 19 : 17,
                  fontWeight: FontWeight.w800,
                  height: 1,
                  color: WellnessColors.textPrimary(context),
                ),
              ),
            ),
          ),

          const SizedBox(width: 10),

          /// CARD
          Expanded(
            child: InkWell(
              borderRadius: BorderRadius.circular(22),
              onTap: onTap,
              child: Container(
                padding: EdgeInsets.symmetric(
                  horizontal: isTablet ? 18 : 16,
                  vertical: isTablet ? 16 : 14,
                ),
                decoration: BoxDecoration(
                  color: WellnessColors.surface(context),
                  borderRadius: BorderRadius.circular(22),
                  border: Border.all(
                    color: WellnessColors.border.withOpacity(
                      isDark ? 0.08 : 0.18,
                    ),
                  ),
                  boxShadow: [
                    BoxShadow(
                      blurRadius: isDark ? 8 : 18,
                      offset: const Offset(0, 8),
                      color: Colors.black.withOpacity(isDark ? 0.12 : 0.04),
                    ),
                  ],
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    /// CONTENT
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          /// MEDICINE NAME (FULL, NO ELLIPSIS)
                          Text(
                            slot.nickname ?? slot.medicineName,
                            maxLines: 3,
                            softWrap: true,
                            overflow: TextOverflow.visible,
                            style: TextStyle(
                              fontSize: isTablet ? 16 : 15,
                              height: 1.35,
                              fontWeight: FontWeight.w700,
                              color: WellnessColors.textPrimary(context),
                            ),
                          ),

                          const SizedBox(height: 6),

                          /// DOSE
                          Text(
                            '${slot.dose} ${t.pills}',
                            style: TextStyle(
                              fontSize: 13,
                              color: WellnessColors.textSecondary(context),
                            ),
                          ),

                          /// FOOD TAG
                          if (slot.withFood != null)
                            Padding(
                              padding: const EdgeInsets.only(top: 10),
                              child: Container(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 10,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: WellnessColors.primary.withOpacity(
                                    0.10,
                                  ),
                                  borderRadius: BorderRadius.circular(999),
                                ),
                                child: Text(
                                  _foodLabel(context, slot.withFood),
                                  style: const TextStyle(
                                    color: WellnessColors.primary,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                              ),
                            ),
                        ],
                      ),
                    ),

                    const SizedBox(width: 8),

                    /// SWITCH
                    Padding(
                      padding: const EdgeInsets.only(top: 2),
                      child: Transform.scale(
                        scale: isTablet ? 0.95 : 0.82,
                        child: Switch(
                          value: slot.notifyEnabled,
                          onChanged: (value) async {
                            await repository.toggleNotify(slot.slotId, value);

                            ref.invalidate(timelineDetailProvider(slot.slotId));
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
