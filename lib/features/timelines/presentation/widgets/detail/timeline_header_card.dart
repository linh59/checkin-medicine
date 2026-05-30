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

    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            WellnessColors.primary,
            WellnessColors.primary.withOpacity(0.85),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(32),
        boxShadow: [
          BoxShadow(
            blurRadius: 30,
            offset: const Offset(0, 12),
            color: WellnessColors.primary.withOpacity(0.18),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// HEADER
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      timeline.name,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.headlineSmall
                          ?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      timeline.profileName.isEmpty ? '' : timeline.profileName,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 15,
                      ),
                    ),
                  ],
                ),
              ),

              /// SWITCH
              Switch(
                value: timeline.isActive,

                onChanged: (value) async {
                  await repo.toggleTimeline(timeline.id, value);

                  ref.invalidate(timelineDetailProvider(timeline.id));
                  ref.invalidate(timelineRepositoryProvider);
                },
              ),
            ],
          ),

          const SizedBox(height: 22),

          /// INFO
          Row(
            children: [
              Expanded(
                child: _InfoCard(
                  title: t.status,
                  value: timeline.isActive ? t.active : t.paused,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: _InfoCard(
                  title: t.medicine,
                  value: '${timeline.slots.length}',
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  final String title;
  final String value;

  const _InfoCard({required this.title, required this.value});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.12),
        borderRadius: BorderRadius.circular(22),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(color: Colors.white70, fontSize: 12),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 17,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}
