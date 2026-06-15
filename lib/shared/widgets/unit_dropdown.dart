import 'package:checkin_medicine/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class UnitDropdown extends StatelessWidget {
  final String? value;

  final ValueChanged<String?> onChanged;

  final List<String> units;

  final String? labelText;

  const UnitDropdown({
    super.key,
    required this.value,
    required this.onChanged,
    this.labelText,
    this.units = const ['mg', 'mcg', 'g', 'kg', 'IU', 'mL', 'L'],
  });

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return DropdownButtonFormField<String>(
      initialValue: units.contains(value) ? value : null,

      decoration: InputDecoration(labelText: labelText ?? t.unit),

      items: units
          .map((unit) => DropdownMenuItem(value: unit, child: Text(unit)))
          .toList(),

      onChanged: onChanged,
    );
  }
}
