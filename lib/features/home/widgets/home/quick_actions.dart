import 'package:checkin_medicine/core/theme/app_colors.dart';
import 'package:checkin_medicine/features/my_medicines/presentation/pages/my_medicines_page.dart';
import 'package:checkin_medicine/features/my_medicines/presentation/providers/my_medicine_provider.dart';
import 'package:checkin_medicine/features/search/presentation/pages/search_page.dart';
import 'package:checkin_medicine/features/timelines/presentation/widgets/detail/create_timeline_dialog.dart';
import 'package:checkin_medicine/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class QuickActions extends ConsumerWidget {
  const QuickActions({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
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
          onTap: () async {
            ref.invalidate(myMedicinesProvider);

            await ref.read(myMedicinesProvider.future);

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
            showDialog(
              context: context,
              builder: (_) => const CreateTimelineDialog(),
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
