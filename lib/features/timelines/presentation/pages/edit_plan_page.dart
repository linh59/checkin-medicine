import 'package:checkin_medicine/features/timelines/presentation/providers/schedules_provider.dart';
import 'package:checkin_medicine/features/timelines/presentation/widgets/dose_stepper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/models/timeline_slot_model.dart';
import '../providers/timelines_provider.dart';
import '../../../../l10n/app_localizations.dart';

class EditPlanItemPage extends ConsumerStatefulWidget {
  final TimelineSlotModel slot;

  const EditPlanItemPage({super.key, required this.slot});

  @override
  ConsumerState<EditPlanItemPage> createState() => _EditPlanItemPageState();
}

class _EditPlanItemPageState extends ConsumerState<EditPlanItemPage> {
  late double dose;
  late TextEditingController noteController;
  late TimeOfDay selectedTime;

  bool loading = false;

  @override
  void initState() {
    super.initState();

    dose = widget.slot.dose.toDouble();

    noteController = TextEditingController(text: widget.slot.withFood ?? '');

    final parts = widget.slot.time.split(':');

    selectedTime = TimeOfDay(
      hour: int.parse(parts[0]),
      minute: int.parse(parts[1]),
    );
  }

  @override
  void dispose() {
    noteController.dispose();
    super.dispose();
  }

  String get timeString {
    final h = selectedTime.hour.toString().padLeft(2, '0');
    final m = selectedTime.minute.toString().padLeft(2, '0');
    return '$h:$m';
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

  Future<void> _save() async {
    setState(() => loading = true);

    try {
      await ref
          .read(schedulesProvider.notifier).updateScheduleOfPlan(
            slot: widget.slot,
            planItemId: widget.slot.planItemId,
            dose: dose,
            time: timeString,
            withFood: noteController.text.trim().isEmpty
                ? null
                : noteController.text,
          );

      if (!mounted) return;

      Navigator.pop(context, 'updated');
    } finally {
      if (mounted) setState(() => loading = false);
    }
  }

  Future<void> _delete() async {
    final confirm = await showDialog<bool>(
      context: context,
      builder: (_) => AlertDialog(
        title: Text(AppLocalizations.of(context)!.delete),
        content: Text(AppLocalizations.of(context)!.confirmDelete),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: Text(AppLocalizations.of(context)!.cancel),
          ),
          FilledButton(
            onPressed: () => Navigator.pop(context, true),
            child: Text(AppLocalizations.of(context)!.delete),
          ),
        ],
      ),
    );

    if (confirm != true) return;

    await ref.read(schedulesProvider.notifier).deleteScheduleOfPlan(widget.slot.slotId);

    if (!mounted) return;

    Navigator.pop(context, 'deleted plan');
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(title: Text(widget.slot.medicineName)),

      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.only(
            left: 16,
            right: 16,
            top: 16,
            bottom: MediaQuery.of(context).viewInsets.bottom + 24,
          ),
          child: Column(
            children: [
              DoseStepper(
                value: dose,
                onChanged: (v) => setState(() => dose = v),
              ),

              const SizedBox(height: 16),

              InkWell(
                onTap: _pickTime,
                child: InputDecorator(
                  decoration: InputDecoration(labelText: t.time),
                  child: Text(timeString),
                ),
              ),

              const SizedBox(height: 16),

              TextFormField(
                controller: noteController,
                maxLines: 2,
                decoration: InputDecoration(labelText: t.withFood),
              ),

              const SizedBox(height: 32),

              SizedBox(
                width: double.infinity,
                height: 52,
                child: FilledButton(
                  onPressed: loading ? null : _save,
                  child: Text(t.save),
                ),
              ),

              const SizedBox(height: 12),

              SizedBox(
                width: double.infinity,
                height: 52,
                child: OutlinedButton(
                  onPressed: loading ? null : _delete,
                  child: Text(t.delete),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
