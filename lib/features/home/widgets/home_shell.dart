import 'package:checkin_medicine/features/home/presentation/pages/home_page.dart';
import 'package:checkin_medicine/features/home/presentation/pages/settings_page.dart';
import 'package:checkin_medicine/features/home/presentation/pages/stats_page.dart';
import 'package:checkin_medicine/features/timelines/presentation/pages/timeline_page.dart';
import 'package:checkin_medicine/features/timelines/presentation/providers/timelines_provider.dart';
import 'package:checkin_medicine/shared/providers/app_refresh_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_colors.dart';
import '../../../l10n/app_localizations.dart';

class HomeShell extends ConsumerStatefulWidget {
  const HomeShell({super.key});

  @override
  ConsumerState<HomeShell> createState() => _HomeShellState();
}

class _HomeShellState extends ConsumerState<HomeShell> {
  int index = 0;

  late final pages = <Widget>[
    const HomePage(),
    const TimelinePage(),
    const StatsPage(),
    const SettingsPage(),
  ];

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return Scaffold(
      body: SafeArea(child: pages[index]),

      bottomNavigationBar: NavigationBar(
        selectedIndex: index,

        onDestinationSelected: (i) async {
          setState(() => index = i);

          ref.read(appRefreshProvider).refreshAll();
        },

        indicatorColor: WellnessColors.primary.withOpacity(0.15),

        destinations: [
          NavigationDestination(
            icon: const Icon(Icons.home_outlined),
            selectedIcon: const Icon(Icons.home),
            label: t.home,
          ),

          NavigationDestination(
            icon: const Icon(Icons.schedule_outlined),
            selectedIcon: const Icon(Icons.schedule),
            label: t.schedule,
          ),

          NavigationDestination(
            icon: const Icon(Icons.bar_chart_outlined),
            selectedIcon: const Icon(Icons.bar_chart),
            label: t.stats,
          ),

          NavigationDestination(
            icon: const Icon(Icons.settings_outlined),
            selectedIcon: const Icon(Icons.settings),
            label: t.settings,
          ),
        ],
      ),
    );
  }
}
