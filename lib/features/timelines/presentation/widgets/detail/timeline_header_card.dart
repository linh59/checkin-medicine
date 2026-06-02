import 'package:checkin_medicine/core/theme/app_colors.dart';
import 'package:checkin_medicine/features/timelines/data/models/timeline_detail_model.dart';
import 'package:checkin_medicine/features/timelines/presentation/providers/timeline_detail_provider.dart';
import 'package:checkin_medicine/features/timelines/presentation/providers/timelines_provider.dart'
    hide timelineRepositoryProvider;
import 'package:checkin_medicine/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TimelineHeaderCard extends ConsumerWidget {
  final TimelineDetailModel timeline;

  const TimelineHeaderCard({super.key, required this.timeline});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = AppLocalizations.of(context)!;
    final repo = ref.read(timelineRepositoryProvider);

    Future<void> deleteTimeline() async {
      final confirm = await showDialog<bool>(
        context: context,
        builder: (_) => AlertDialog(
          title: Text(t.confirm),
          content: Text(t.deleteTimelineConfirm),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, false),
              child: Text(t.cancel),
            ),
            FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: WellnessColors.error,
              ),
              onPressed: () => Navigator.pop(context, true),
              child: Text(t.delete),
            ),
          ],
        ),
      );

      if (confirm != true) return;

      await repo.deleteTimeline(timeline.id);

      if (!context.mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(t.deleteSuccess)));

      Navigator.pop(context, 'deleted');
    }

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: WellnessColors.border),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// TOP ROW
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      timeline.name,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      timeline.profileName.isEmpty
                          ? t.noProfile
                          : timeline.profileName,
                      style: TextStyle(
                        fontSize: 13,
                        color: WellnessColors.textSecondary(context),
                      ),
                    ),
                  ],
                ),
              ),

              /// SWITCH (smaller)
              Transform.scale(
                scale: 0.85,
                child: Switch(
                  value: timeline.isActive,
                  onChanged: (value) async {
                    await repo.toggleTimeline(timeline.id, value);

                    ref.invalidate(timelineDetailProvider(timeline.id));
                    ref.invalidate(timelineRepositoryProvider);
                  },
                ),
              ),

              /// DELETE ICON (CLEAN)
              IconButton(
                icon: const Icon(Icons.delete_outline),
                color: WellnessColors.error,
                onPressed: deleteTimeline,
              ),
            ],
          ),

          const SizedBox(height: 12),

          /// INFO ROW (compact instead of cards)
          Row(
            children: [
              _MiniInfo(
                label: t.status,
                value: timeline.isActive ? t.active : t.paused,
              ),
              const SizedBox(width: 16),
              _MiniInfo(label: t.medicine, value: '${timeline.slots.length}'),
            ],
          ),
        ],
      ),
    );
  }
}

class _MiniInfo extends StatelessWidget {
  final String label;
  final String value;

  const _MiniInfo({required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            color: WellnessColors.textSecondary(context),
          ),
        ),
        const SizedBox(height: 2),
        Text(
          value,
          style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700),
        ),
      ],
    );
  }
}
