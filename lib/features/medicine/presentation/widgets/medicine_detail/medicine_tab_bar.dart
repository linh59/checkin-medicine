import 'package:flutter/material.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../l10n/app_localizations.dart';

class MedicineTabBar extends StatelessWidget {
  final TabController controller;

  const MedicineTabBar({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final colorScheme = Theme.of(context).colorScheme;

    return Container(
      height: 58,
      padding: const EdgeInsets.all(6),
      decoration: BoxDecoration(
        color: colorScheme.surfaceContainerLow,
        borderRadius: BorderRadius.circular(20),
      ),

      child: TabBar(
        controller: controller,



        dividerColor: Colors.transparent,
        indicatorSize: TabBarIndicatorSize.tab,

        indicator: BoxDecoration(
          color: WellnessColors.primary,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 12,
              offset: const Offset(0, 3),
            ),
          ],
        ),

        labelColor: Colors.white,
        unselectedLabelColor: colorScheme.onSurfaceVariant,

        labelStyle: Theme.of(context)
            .textTheme
            .labelLarge
            ?.copyWith(fontWeight: FontWeight.w700),

        unselectedLabelStyle: Theme.of(context)
            .textTheme
            .labelLarge
            ?.copyWith(fontWeight: FontWeight.w600),

        tabs: [
          Tab(text: t.overview),
          Tab(text: t.ingredients),
          Tab(text: t.warnings),
        ],
      ),
    );
  }
}