import 'package:flutter/material.dart';

import '../../../../l10n/app_localizations.dart';

class EmptyMyMedicine extends StatelessWidget {
  const EmptyMyMedicine({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment:
          MainAxisAlignment.center,
          children: [
            CircleAvatar(
              radius: 34,
              child: Icon(
                Icons.medication_rounded,
                size: 34,
              ),
            ),

            const SizedBox(height: 16),

            Text(
              l10n.noMedicinesYet,
              style: Theme.of(context)
                  .textTheme
                  .titleLarge,
            ),

            const SizedBox(height: 8),

            Text(
              l10n.addMedicineDescription,
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}