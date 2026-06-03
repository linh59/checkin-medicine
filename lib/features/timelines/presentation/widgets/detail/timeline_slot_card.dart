import 'package:checkin_medicine/features/timelines/data/models/timeline_slot_model.dart';
import 'package:checkin_medicine/features/timelines/presentation/pages/edit_plan_page.dart';
import 'package:checkin_medicine/features/timelines/presentation/providers/timelines_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:checkin_medicine/l10n/app_localizations.dart';

class TimelineSlotCard extends ConsumerWidget {
  final TimelineSlotModel slot;
  final VoidCallback onTap;
  final Future<void> Function(String action)? onRefresh;

  const TimelineSlotCard({
    super.key,
    required this.slot,
    required this.onTap,
    this.onRefresh,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: colorScheme.outlineVariant.withOpacity(0.4),
            ),
          ),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    /// TIME
                    Text(
                      slot.time,
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                      ),
                    ),

                    /// SWITCH
                    Transform.scale(
                      scale: 0.7,
                      child: Switch(
                        value: slot.notifyEnabled,
                        onChanged: (value) async {
                          final repo = ref.read(timelineRepositoryProvider);
                          await repo.toggleNotify(slot.slotId, value);

                          ref.invalidate(timelineDetailProvider(slot.slotId));
                        },
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(width: 10),

              /// CONTENT
              Expanded(
                child: InkWell(
                  onTap: onTap,

                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      /// NAME + EDIT
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              slot.nickname ?? slot.medicineName,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),

                          IconButton(
                            visualDensity: VisualDensity.compact,
                            icon: const Icon(Icons.edit_outlined, size: 18),
                            onPressed: () async {
                              final result = await Navigator.push<String>(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => EditPlanItemPage(slot: slot),
                                ),
                              );

                              if (result != null && context.mounted) {
                                await onRefresh?.call(result);
                              }
                            },
                          ),
                        ],
                      ),

                      const SizedBox(height: 4),

                      /// DOSE
                      Text(
                        '${slot.dose} ${t.pills}',
                        style: TextStyle(
                          fontSize: 14,
                          color: colorScheme.onSurfaceVariant,
                        ),
                      ),

                      /// WITH FOOD
                      if (slot.withFood != null &&
                          slot.withFood!.trim().isNotEmpty)
                        Padding(
                          padding: const EdgeInsets.only(top: 6),
                          child: Text(
                            slot.withFood!,
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                              fontSize: 14,
                              height: 1.3,
                              color: colorScheme.onSurfaceVariant,
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),

        const SizedBox(height: 6),
      ],
    );
  }
}
