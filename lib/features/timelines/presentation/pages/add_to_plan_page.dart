import 'package:checkin_medicine/features/my_medicines/presentation/providers/my_medicine_provider.dart';
import 'package:checkin_medicine/features/timelines/presentation/providers/schedules_provider.dart';
import 'package:checkin_medicine/features/timelines/presentation/widgets/dose_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../l10n/app_localizations.dart';
import '../providers/timelines_provider.dart';

class AddToPlanPage extends ConsumerStatefulWidget {
  final String planId;

  const AddToPlanPage({super.key, required this.planId});

  @override
  ConsumerState<AddToPlanPage> createState() => _AddToPlanPageState();
}

class _AddToPlanPageState extends ConsumerState<AddToPlanPage> {
  String? selectedMedicineId;

  double dose = 1;
  final noteController = TextEditingController();

  TimeOfDay selectedTime = const TimeOfDay(hour: 8, minute: 0);

  bool loading = false;

  @override
  void dispose() {
    noteController.dispose();
    super.dispose();
  }

  Future<void> _pickTime() async {
    final result = await showTimePicker(
      context: context,
      initialTime: selectedTime,
    );

    if (result != null) {
      setState(() => selectedTime = result);
    }
  }

  String get timeString {
    final h = selectedTime.hour.toString().padLeft(2, '0');
    final m = selectedTime.minute.toString().padLeft(2, '0');
    return '$h:$m';
  }

  Future<void> _add() async {
    final t = AppLocalizations.of(context)!;

    FocusScope.of(context).unfocus();

    if (selectedMedicineId == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(t.selectMedicine)));
      return;
    }

    setState(() => loading = true);

    try {
      await ref
          .read(schedulesProvider.notifier)
          .addScheduleToPlan(
            planId: widget.planId,
            myMedicineId: selectedMedicineId!,
            dose: dose,
            time: timeString,
            withFood: noteController.text.trim().isEmpty
                ? null
                : noteController.text,
          );

      if (!mounted) return;

      Navigator.pop(context, 'added plan');
    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    } finally {
      if (mounted) setState(() => loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final medicinesAsync = ref.watch(myMedicinesProvider);

    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        appBar: AppBar(title: Text(t.addToPlan)),

        bottomNavigationBar: SafeArea(
          child: Padding(
            padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
            child: SizedBox(
              height: 52,
              child: FilledButton(
                onPressed: loading ? null : _add,
                child: loading
                    ? const CircularProgressIndicator(strokeWidth: 2)
                    : Text(t.add),
              ),
            ),
          ),
        ),

        body: medicinesAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(child: Text(e.toString())),
          data: (medicines) {
            return SingleChildScrollView(
              padding: EdgeInsets.fromLTRB(
                16,
                16,
                16,
                MediaQuery.of(context).viewInsets.bottom + 24,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  DropdownButtonFormField<String>(
                    value: selectedMedicineId,
                    decoration: InputDecoration(
                      labelText: t.medicine,
                      border: const OutlineInputBorder(),
                    ),
                    items: medicines.map((m) {
                      return DropdownMenuItem(
                        value: m.id,
                        child: Text(
                          (m.nickname?.isNotEmpty ?? false)
                              ? m.nickname!
                              : (m.medicine?.brand ?? ''),
                        ),
                      );
                    }).toList(),
                    onChanged: (value) {
                      setState(() => selectedMedicineId = value);
                    },
                  ),

                  const SizedBox(height: 16),

                  DoseStepper(
                    value: dose,
                    onChanged: (v) => setState(() => dose = v),
                  ),

                  const SizedBox(height: 16),

                  InkWell(
                    onTap: _pickTime,
                    borderRadius: BorderRadius.circular(12),
                    child: InputDecorator(
                      decoration: InputDecoration(
                        labelText: t.time,
                        border: const OutlineInputBorder(),
                      ),
                      child: Text(timeString),
                    ),
                  ),

                  const SizedBox(height: 16),

                  TextFormField(
                    controller: noteController,
                    maxLines: 2,
                    decoration: InputDecoration(
                      labelText: t.withFood,
                      hintText: t.withFoodHint,
                      border: const OutlineInputBorder(),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
