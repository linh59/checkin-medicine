import 'package:flutter/material.dart';

import '../../../../l10n/app_localizations.dart';

class SchedulePage extends StatelessWidget {
  const SchedulePage({super.key});


  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(t.schedule),

      ),
      body: Center(
        child: Text(
          t.schedule,
          style: const TextStyle(fontSize: 24),
        ),
      ),
    );
  }
}