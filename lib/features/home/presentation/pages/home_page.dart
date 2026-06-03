import 'package:checkin_medicine/features/home/widgets/home/today_timline.dart';
import 'package:checkin_medicine/features/my_medicines/presentation/pages/my_medicines_page.dart';
import 'package:checkin_medicine/features/search/presentation/pages/search_page.dart';
import 'package:checkin_medicine/features/timelines/presentation/pages/timeline_page.dart';
import 'package:flutter/material.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../l10n/app_localizations.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),

        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // HEADER
            Text(
              "${t.homeGreeting} 👋",
              style: Theme.of(
                context,
              ).textTheme.headlineSmall?.copyWith(fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 6),

            Text(
              t.todayScheduleSubtitle,
              style: const TextStyle(color: Colors.grey),
            ),

            const SizedBox(height: 20),

            // ⚡ QUICK ACTIONS
            _QuickActions(),

            const SizedBox(height: 20),

            // 🛡 SAFETY CARD
            _SafetyCard(),

            const SizedBox(height: 20),

            TodayList(),

            const SizedBox(height: 20),

            // FAMILY
            // _FamilySection(),
          ],
        ),
      ),
    );
  }
}

class _QuickActions extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return GridView(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),

      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        childAspectRatio: 1,
      ),

      children: [
        _ActionCard(
          icon: Icons.add,
          label: t.addMedicine,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const SearchPage()),
            );
          },
        ),

        _ActionCard(
          icon: Icons.medication,
          label: t.pharmacy,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const MyMedicinesPage()),
            );
          },
        ),

        _ActionCard(
          icon: Icons.calendar_month,
          label: t.createSchedule,
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (_) => const TimelinePage()),
            );
          },
        ),
      ],
    );
  }
}

class _ActionCard extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;

  const _ActionCard({
    super.key,
    required this.icon,
    required this.label,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(16),
      onTap: onTap,

      child: Container(
        decoration: BoxDecoration(
          color: Theme.of(context).colorScheme.surface,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.black12),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: WellnessColors.primary),

            const SizedBox(height: 8),

            Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 12),
            ),
          ],
        ),
      ),
    );
  }
}

class _SafetyCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: WellnessColors.primary.withOpacity(0.08),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Row(
        children: [
          const Icon(Icons.health_and_safety, color: WellnessColors.primary),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              t.todaySafetySummary,
              style: const TextStyle(fontSize: 13),
            ),
          ),
        ],
      ),
    );
  }
}

class _FamilySection extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(t.family, style: Theme.of(context).textTheme.titleMedium),
            TextButton(onPressed: () {}, child: Text(t.manage)),
          ],
        ),

        const SizedBox(height: 10),

        SizedBox(
          height: 110,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: const [
              _FamilyCard(name: "Me", isSelf: true),
              _FamilyCard(name: "Mom"),
              _FamilyCard(name: "Dad"),
              _AddFamilyCard(),
            ],
          ),
        ),
      ],
    );
  }
}

class _FamilyCard extends StatelessWidget {
  final String name;
  final bool isSelf;

  const _FamilyCard({required this.name, this.isSelf = false});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 140,
      margin: const EdgeInsets.only(right: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.black12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.medical_information, color: WellnessColors.primary),
          const SizedBox(height: 8),
          Text(name, style: const TextStyle(fontWeight: FontWeight.bold)),
          Text(isSelf ? "Me" : "Family", style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }
}

class _AddFamilyCard extends StatelessWidget {
  const _AddFamilyCard();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 110,
      margin: const EdgeInsets.only(right: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.black12),
      ),
      child: const Center(child: Icon(Icons.add)),
    );
  }
}
