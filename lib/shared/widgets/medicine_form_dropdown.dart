import 'package:checkin_medicine/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class MedicineFormDropdown extends StatelessWidget {
  final String value;

  final ValueChanged<String?> onChanged;

  const MedicineFormDropdown({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return DropdownButtonFormField<String>(
      value: value,

      decoration: InputDecoration(labelText: t.form),

      items: [
        DropdownMenuItem(value: 'tablet', child: Text(t.tablet)),
        DropdownMenuItem(value: 'capsule', child: Text(t.capsule)),
        DropdownMenuItem(value: 'softgel', child: Text(t.softgel)),
        DropdownMenuItem(value: 'powder', child: Text(t.powder)),
        DropdownMenuItem(value: 'effervescent', child: Text(t.effervescent)),
      ],

      onChanged: onChanged,
    );
  }
}
