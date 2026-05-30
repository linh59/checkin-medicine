import 'package:checkin_medicine/features/medicine/presentation/pages/medicine_detail_page.dart';
import 'package:checkin_medicine/features/timelines/data/models/timeline_detail_model.dart';
import 'package:checkin_medicine/features/timelines/data/models/timeline_slot_model.dart';
import 'package:checkin_medicine/features/timelines/presentation/widgets/detail/timeline_slot_card.dart';
import 'package:checkin_medicine/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class TimelineScheduleTab extends StatelessWidget {
  final TabController controller;
  final TimelineDetailModel timeline;

  const TimelineScheduleTab({
    super.key,
    required this.controller,
    required this.timeline,
  });

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;

    return Column(
      children: [
        /// TAB BAR
        _TimelineTabBar(controller: controller),

        const SizedBox(height: 12),

        /// CONTENT
        SizedBox(
          height: MediaQuery.sizeOf(context).height * 0.6,

          child: TabBarView(
            controller: controller,

            children: [
              /// SCHEDULE
              _ScheduleContent(slots: timeline.slots),

              /// SAFETY
              _SafetyContent(title: t.safety, subtitle: t.comingSoon),
            ],
          ),
        ),
      ],
    );
  }
}

class _TimelineTabBar extends StatelessWidget {
  final TabController controller;

  const _TimelineTabBar({required this.controller});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;
    final t = AppLocalizations.of(context)!;

    return Container(
      height: 56,
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(18),
      ),

      child: LayoutBuilder(
        builder: (context, constraints) {
          final tabWidth = constraints.maxWidth / 2;

          return AnimatedBuilder(
            animation: controller.animation!,
            builder: (context, _) {
              final value = controller.animation!.value;

              return Stack(
                children: [
                  AnimatedPositioned(
                    duration: const Duration(milliseconds: 200),
                    left: value * tabWidth,

                    child: Container(
                      width: tabWidth,
                      height: 48,
                      decoration: BoxDecoration(
                        color: colorScheme.primary,
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                  ),

                  Row(
                    children: [
                      _TabItem(
                        label: t.schedule,
                        isActive: controller.index == 0,
                        onTap: () => controller.animateTo(0),
                      ),
                      _TabItem(
                        label: t.safety,
                        isActive: controller.index == 1,
                        onTap: () => controller.animateTo(1),
                      ),
                    ],
                  ),
                ],
              );
            },
          );
        },
      ),
    );
  }
}

class _TabItem extends StatelessWidget {
  final String label;
  final bool isActive;
  final VoidCallback onTap;

  const _TabItem({
    required this.label,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          alignment: Alignment.center,
          height: 48,
          child: Text(
            label,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              color: isActive ? Colors.white : colorScheme.onSurfaceVariant,
            ),
          ),
        ),
      ),
    );
  }
}

class _ScheduleContent extends StatelessWidget {
  final List<TimelineSlotModel> slots;

  const _ScheduleContent({required this.slots});

  @override
  Widget build(BuildContext context) {
    if (slots.isEmpty) {
      return const Center(child: Text("No schedule"));
    }

    return ListView.separated(
      padding: const EdgeInsets.all(16),

      itemCount: slots.length,

      separatorBuilder: (_, __) => const SizedBox(height: 12),

      itemBuilder: (context, index) {
        final slot = slots[index];

        return TimelineSlotCard(
          slot: slot,
          isLast: index == slots.length - 1,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => MedicineDetailPage(
                  slug: slot.medicineSlug,
                  isAddedMedicine: true,
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class _SafetyContent extends StatelessWidget {
  final String title;
  final String subtitle;

  const _SafetyContent({required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.health_and_safety, size: 64, color: colorScheme.primary),

          const SizedBox(height: 12),

          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
          ),

          const SizedBox(height: 6),

          Text(subtitle),
        ],
      ),
    );
  }
}
