import 'package:checkin_medicine/core/theme/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:checkin_medicine/l10n/app_localizations.dart';

class DoseStepper extends StatelessWidget {
  final double value;
  final ValueChanged<double> onChanged;
  final double step;

  const DoseStepper({
    super.key,
    required this.value,
    required this.onChanged,
    this.step = 0.5,
  });

  String get displayText {
    if (value % 1 == 0) {
      return value.toInt().toString();
    }
    return value.toString();
  }

  void _increase() {
    onChanged(value + step);
  }

  void _decrease() {
    if (value <= step) return;
    onChanged(value - step);
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return Container(
      padding: const EdgeInsets.all(16),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(t.dose, style: const TextStyle(fontWeight: FontWeight.w600)),

          const SizedBox(height: 12),

          Row(
            children: [
              IconButton.filled(
                onPressed: _decrease,
                icon: const Icon(Icons.remove),
              ),

              Expanded(
                child: Center(
                  child: Text(
                    '$displayText ${t.pills}',
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ),

              IconButton.filled(
                onPressed: _increase,
                icon: const Icon(Icons.add),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
