import 'package:checkin_medicine/features/medicines_management/data/repositories/admin_medicine_repository.dart';
import 'package:checkin_medicine/features/nutrient/data/models/ingredient_form_model.dart';
import 'package:flutter/material.dart';

class IngredientFormsPickerButton extends StatefulWidget {
  final String nutrientId;

  final List<IngredientForm> selectedForms;

  final ValueChanged<List<IngredientForm>> onSelected;

  const IngredientFormsPickerButton({
    super.key,
    required this.nutrientId,
    required this.selectedForms,
    required this.onSelected,
  });

  @override
  State<IngredientFormsPickerButton> createState() =>
      _IngredientFormsPickerButtonState();
}

class _IngredientFormsPickerButtonState
    extends State<IngredientFormsPickerButton> {
  final _repo = AdminMedicineRepository();

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<IngredientForm>>(
      future: _repo.getFormsByNutrient(widget.nutrientId),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const SizedBox(
            height: 56,
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }

        final forms = snapshot.data!;

        return OutlinedButton.icon(
          icon: const Icon(Icons.science_outlined),
          label: Align(
            alignment: Alignment.centerLeft,
            child: Text(
              widget.selectedForms.isEmpty
                  ? 'Select ingredient forms (optional)'
                  : widget.selectedForms
                  .map((e) => e.name)
                  .join(', '),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          onPressed: () async {
            final result =
            await showModalBottomSheet<List<IngredientForm>>(
              context: context,
              isScrollControlled: true,
              useSafeArea: true,
              builder: (_) => _IngredientFormsBottomSheet(
                forms: forms,
                selected: widget.selectedForms,
              ),
            );

            if (result != null) {
              widget.onSelected(result);
            }
          },
        );
      },
    );
  }
}

class _IngredientFormsBottomSheet extends StatefulWidget {
  final List<IngredientForm> forms;

  final List<IngredientForm> selected;

  const _IngredientFormsBottomSheet({
    required this.forms,
    required this.selected,
  });

  @override
  State<_IngredientFormsBottomSheet> createState() =>
      _IngredientFormsBottomSheetState();
}

class _IngredientFormsBottomSheetState
    extends State<_IngredientFormsBottomSheet> {
  late List<IngredientForm> selected;

  @override
  void initState() {
    super.initState();
    selected = [...widget.selected];
  }

  @override
  Widget build(BuildContext context) {
    return DraggableScrollableSheet(
      expand: false,
      builder: (_, controller) {
        return Column(
          children: [
            const SizedBox(height: 12),

            Container(
              width: 48,
              height: 4,
              decoration: BoxDecoration(
                color: Colors.grey.shade400,
                borderRadius: BorderRadius.circular(100),
              ),
            ),

            const SizedBox(height: 16),

            const Text(
              'Ingredient Forms',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),

            Expanded(
              child: ListView.builder(
                controller: controller,
                itemCount: widget.forms.length,
                itemBuilder: (_, index) {
                  final form = widget.forms[index];

                  final checked = selected.any(
                        (e) => e.id == form.id,
                  );

                  return CheckboxListTile(
                    value: checked,
                    title: Text(form.name),
                    subtitle: form.saltForm == null
                        ? null
                        : Text(form.saltForm!),
                    onChanged: (value) {
                      setState(() {
                        if (value == true) {
                          selected.add(form);
                        } else {
                          selected.removeWhere(
                                (e) => e.id == form.id,
                          );
                        }
                      });
                    },
                  );
                },
              ),
            ),

            SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16),
                child: FilledButton(
                  onPressed: () {
                    Navigator.pop(context, selected);
                  },
                  child: const Text('Done'),
                ),
              ),
            ),
          ],
        );
      },
    );
  }
}