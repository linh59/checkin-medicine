import 'package:checkin_medicine/features/timelines/data/models/timeline_slot_model.dart';
import 'package:checkin_medicine/features/timelines/presentation/providers/schedules_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:checkin_medicine/l10n/app_localizations.dart';

class NotifySettingsPage extends ConsumerStatefulWidget {
  final TimelineSlotModel slot;

  const NotifySettingsPage({
    super.key,
    required this.slot,
  });

  @override
  ConsumerState<NotifySettingsPage> createState() =>
      _NotifySettingsPageState();
}

class _NotifySettingsPageState extends ConsumerState<NotifySettingsPage> {
  late bool enabled;
  late int offsetMin;
  bool loading = false;

  @override
  void initState() {
    super.initState();
    enabled = widget.slot.notifyEnabled;
    offsetMin = widget.slot.notifyOffsetMin ?? 0;
  }

  Future<void> _save() async {
    setState(() => loading = true);

    try {

      await ref.read(schedulesProvider.notifier).updateNotify(
        slot: widget.slot,
        enabled: enabled,
        offsetMin: offsetMin,
      );

      if (mounted) {
        Navigator.pop(context, 'notify updated');
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(e.toString())),
        );
      }
    }

    setState(() => loading = false);
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(t.notificationSettings),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SwitchListTile(
              value: enabled,
              title: Text(t.enableNotification),
              onChanged: (v) => setState(() => enabled = v),
            ),

            const SizedBox(height: 16),

            if (enabled) ...[
              Text(
                t.notifyBefore,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),

              const SizedBox(height: 8),

              Wrap(
                spacing: 8,
                children: [0, 5, 15, 30, 60].map((min) {
                  return ChoiceChip(
                    label: Text(
                      min == 0
                          ? t.onTime
                          : "$min ${t.minutes}",
                    ),
                    selected: offsetMin == min,
                    onSelected: (_) {
                      setState(() => offsetMin = min);
                    },
                  );
                }).toList(),
              ),
            ],

            const Spacer(),

            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: loading ? null : _save,
                child: loading
                    ? const CircularProgressIndicator()
                    : Text(t.save),
              ),
            ),

            const SizedBox(height: 60),
          ],
        ),
      ),
    );
  }
}