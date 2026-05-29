import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../auth/presentation/providers/profile_provider.dart';
import '../providers/my_medicine_provider.dart';

class AddMedicineSheet extends ConsumerStatefulWidget {
  final String medicineId;
  final String brand;

  const AddMedicineSheet({
    super.key,
    required this.medicineId,
    required this.brand,
  });

  @override
  ConsumerState<AddMedicineSheet> createState() => _AddMedicineSheetState();
}

class _AddMedicineSheetState extends ConsumerState<AddMedicineSheet> {
  final nicknameCtrl = TextEditingController();
  final notesCtrl = TextEditingController();

  bool get loading => ref.watch(addMyMedicineProvider).isLoading;

  Future<void> submit() async {
    final t = AppLocalizations.of(context)!;
    final profile = ref.read(profileProvider).profile;

    if (profile == null) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(t.noProfile)));
      return;
    }

    try {
      await ref
          .read(addMyMedicineProvider.notifier)
          .add(
            profileId: profile.id,
            medicineId: widget.medicineId,
            nickname: nicknameCtrl.text.trim().isEmpty
                ? null
                : nicknameCtrl.text.trim(),
            notes: notesCtrl.text.trim().isEmpty ? null : notesCtrl.text.trim(),
          );
      if (mounted) Navigator.pop(context);

      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(t.addMedicineSuccess)));
    } catch (e) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(e.toString())));
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final bottomInset = MediaQuery.of(context).viewInsets.bottom;

    return AnimatedPadding(
      duration: const Duration(milliseconds: 200),
      curve: Curves.easeOut,
      padding: EdgeInsets.only(bottom: bottomInset),
      child: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.fromLTRB(16, 12, 16, 16),
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                /// HANDLE BAR
                Center(
                  child: Container(
                    width: 40,
                    height: 4,
                    margin: const EdgeInsets.only(bottom: 16),
                    decoration: BoxDecoration(
                      color: Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(99),
                    ),
                  ),
                ),

                /// TITLE
                Text(
                  t.add_medicine_title(widget.brand),
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w700),
                ),

                const SizedBox(height: 20),

                /// NICKNAME FIELD
                TextField(
                  controller: nicknameCtrl,
                  decoration: InputDecoration(
                    labelText: t.nickname,
                    hintText: t.nicknameHint,
                    prefixIcon: const Icon(Icons.label_outline),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ),

                const SizedBox(height: 14),

                /// NOTES FIELD
                TextField(
                  controller: notesCtrl,
                  maxLines: 3,
                  decoration: InputDecoration(
                    labelText: t.notes,
                    hintText: t.notesHint,
                    prefixIcon: const Icon(Icons.notes),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(14),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                /// BUTTON
                SizedBox(
                  width: double.infinity,
                  height: 52,
                  child: ElevatedButton(
                    onPressed: loading ? null : submit,
                    style: ElevatedButton.styleFrom(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14),
                      ),
                    ),
                    child: loading
                        ? const SizedBox(
                            height: 18,
                            width: 18,
                            child: CircularProgressIndicator(
                              strokeWidth: 2,
                              color: Colors.white,
                            ),
                          )
                        : Text(t.saveToMyMedicine),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
