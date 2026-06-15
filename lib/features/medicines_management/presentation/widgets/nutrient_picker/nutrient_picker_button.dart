import 'package:checkin_medicine/features/medicines_management/presentation/providers/nutrient_search_provider.dart';
import 'package:checkin_medicine/features/medicines_management/presentation/widgets/nutrient_picker/nutrient_picker_dialog.dart';
import 'package:checkin_medicine/features/nutrient/data/models/nutrient_model.dart';
import 'package:checkin_medicine/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class NutrientPickerButton extends ConsumerWidget {
  final String? selectedName;

  final ValueChanged<NutrientModel> onSelected;

  const NutrientPickerButton({
    super.key,
    required this.selectedName,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final t = AppLocalizations.of(context)!;

    return OutlinedButton(
      onPressed: () async {
        ref.read(nutrientSearchQueryProvider.notifier).state = '';

        await showDialog(
          context: context,
          builder: (_) {
            return NutrientPickerDialog(onSelected: onSelected);
          },
        );
      },
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(selectedName ?? t.selectNutrient),
      ),
    );
  }
}
