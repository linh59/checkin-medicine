import 'package:checkin_medicine/features/medicines_management/presentation/widgets/medicine_form_widget.dart';
import 'package:checkin_medicine/l10n/app_localizations.dart';
import 'package:flutter/material.dart';

class CreateMedicinePage extends StatelessWidget {
  const CreateMedicinePage({super.key});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(t.createMedicine)),
      body: const SafeArea(child: MedicineFormWidget()),
    );
  }
}
