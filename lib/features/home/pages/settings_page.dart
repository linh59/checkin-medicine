import 'package:checkin_medicine/shared/widgets/theme_switcher.dart';
import 'package:flutter/material.dart';

import '../../../../l10n/app_localizations.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});


  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(t.stats),

      ),
      body: Column(
        children: [
          Text(
            t.settings,
            style: const TextStyle(fontSize: 24),
          ),
          const ThemeSwitcher()
        ]
      ),
    );
  }
}