import 'package:checkin_medicine/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AmountOfServingField extends StatelessWidget {
  final ValueChanged<double> onChanged;

  const AmountOfServingField({
    super.key,
    required this.onChanged,
  });

  double? _parse(String value) {
    if (value.trim().isEmpty) return null;

    final normalized = value.replaceAll(',', '.');

    return double.tryParse(normalized);
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return TextFormField(

      keyboardType: const TextInputType.numberWithOptions(
        decimal: true,
      ),

      inputFormatters: [
        FilteringTextInputFormatter.allow(
          RegExp(r'[0-9.,]'),
        ),
      ],

      decoration: InputDecoration(
        labelText: t.amountOfServing,
        border: const OutlineInputBorder(),
      ),

      validator: (value) {
        if (value == null || value.trim().isEmpty) {
          return t.pleaseEnterAmountOfServing;
        }

        if (_parse(value) == null) {
          return t.invalidNumber;
        }

        return null;
      },

      onChanged: (value) {
        final amount = _parse(value);

        if (amount != null) {
          onChanged(amount);
        }
      },
    );
  }
}