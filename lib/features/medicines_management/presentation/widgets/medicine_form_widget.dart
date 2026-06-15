import 'package:checkin_medicine/features/medicines_management/data/models/ingredient_row.dart';
import 'package:checkin_medicine/features/medicines_management/data/models/medicine_form.dart';
import 'package:checkin_medicine/features/medicines_management/presentation/widgets/ingredient_picker.dart';
import 'package:checkin_medicine/l10n/app_localizations.dart';
import 'package:checkin_medicine/shared/widgets/medicine_form_dropdown.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/create_medicine_provider.dart';

class MedicineFormWidget extends ConsumerStatefulWidget {
  const MedicineFormWidget({super.key});

  @override
  ConsumerState<MedicineFormWidget> createState() => _MedicineFormWidgetState();
}

class _MedicineFormWidgetState extends ConsumerState<MedicineFormWidget> {
  final _formKey = GlobalKey<FormState>();

  final brandController = TextEditingController();

  final genericController = TextEditingController();

  final slugController = TextEditingController();

  final manufacturerController = TextEditingController();

  final countryController = TextEditingController();

  final summaryController = TextEditingController();

  final descriptionController = TextEditingController();

  final pillsPerServingController = TextEditingController(text: '1');

  final warningController = TextEditingController();

  String form = 'tablet';

  String? category;

  int pillsPerServing = 1;
  List<IngredientRow> ingredientRows = [];
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.listenManual(createMedicineProvider, (previous, next) {
        next.whenOrNull(
          data: (medicineId) {
            if (medicineId == null || !mounted) {
              return;
            }

            Navigator.of(context).pop(true);
          },
          error: (e, _) {
            if (!mounted) {
              return;
            }

            ScaffoldMessenger.of(
              context,
            ).showSnackBar(SnackBar(content: Text(e.toString())));
          },
        );
      });
    });
  }

  @override
  void dispose() {
    brandController.dispose();
    genericController.dispose();
    slugController.dispose();
    manufacturerController.dispose();
    countryController.dispose();
    summaryController.dispose();
    descriptionController.dispose();
    pillsPerServingController.dispose();
    warningController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    final state = ref.watch(createMedicineProvider);

    return Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          _section(
            title: t.basicInformation,
            children: [
              TextFormField(
                controller: brandController,
                decoration: InputDecoration(labelText: t.medicineName),
                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Required';
                  }

                  return null;
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: genericController,
                decoration: InputDecoration(labelText: t.genericName),
              ),
              const SizedBox(height: 12),

              TextFormField(
                controller: summaryController,
                maxLines: 3,
                decoration: InputDecoration(labelText: t.summary),
              ),
            ],
          ),
          const SizedBox(height: 16),

          _section(
            title: t.manufacturer,
            children: [
              TextFormField(
                controller: manufacturerController,
                decoration: InputDecoration(labelText: t.manufacturer),
              ),

              const SizedBox(height: 12),

              TextFormField(
                controller: countryController,
                decoration: InputDecoration(labelText: t.country),
              ),
            ],
          ),

          const SizedBox(height: 16),

          _section(
            title: t.basicInformation,
            children: [
              MedicineFormDropdown(
                value: form,
                onChanged: (value) {
                  if (value == null) return;

                  setState(() {
                    form = value;
                  });
                },
              ),
              const SizedBox(height: 12),
              TextFormField(
                controller: pillsPerServingController,
                keyboardType: TextInputType.number,
                decoration: InputDecoration(labelText: t.pillsPerServing),
                onChanged: (value) {
                  setState(() {
                    pillsPerServing = int.tryParse(value) ?? 1;
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 16),
          _section(
            title: t.ingredients,
            children: [
              IngredientPicker(
                rows: ingredientRows,
                pillsPerServing: pillsPerServing,

                onChanged: (value) {
                  setState(() {
                    ingredientRows = value;
                  });
                },
              ),
            ],
          ),
          const SizedBox(height: 16),

          _section(
            title: t.warnings,
            children: [
              TextFormField(
                controller: warningController,
                maxLines: 5,
                decoration: InputDecoration(labelText: t.warnings),
              ),
            ],
          ),

          const SizedBox(height: 24),

          ElevatedButton(
            onPressed: state.isLoading
                ? null
                : () async {
                    if (!_formKey.currentState!.validate()) {
                      return;
                    }

                    final model = MedicineForm(
                      brand: brandController.text,
                      genericName: genericController.text,
                      slug: slugController.text,
                      form: form,
                      category: category,
                      manufacturer: manufacturerController.text,
                      country: countryController.text,
                      summary: summaryController.text,
                      description: descriptionController.text,
                      pillsPerServing: pillsPerServing,
                      warnings: warningController.text
                          .split('\n')
                          .where((e) => e.trim().isNotEmpty)
                          .toList(),

                      ingredients: ingredientRows
                          .where((e) => e.input.formId.isNotEmpty)
                          .map((e) => e.input)
                          .toList(),
                    );
                    await ref
                        .read(createMedicineProvider.notifier)
                        .createMedicine(model);
                  },
            child: state.isLoading
                ? const CircularProgressIndicator()
                : Text(t.saveMedicine),
          ),
        ],
      ),
    );
  }

  Widget _section({required String title, required List<Widget> children}) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ...children,
          ],
        ),
      ),
    );
  }
}
