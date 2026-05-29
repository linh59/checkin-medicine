import 'package:checkin_medicine/features/my_medicines/presentation/widgets/add_medicine_sheet.dart';
import 'package:flutter/material.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../l10n/app_localizations.dart';
import '../../../data/models/medicine_detail_model.dart';

class BottomAction extends StatelessWidget {
  final Medicine medicine;

  const BottomAction({super.key, required this.medicine});

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;

    return SafeArea(
      top: false,
      child: Container(
        padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),

        decoration: BoxDecoration(
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20),
            topRight: Radius.circular(20),
          ),

          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 18,
              offset: const Offset(0, -2),
            ),
          ],
        ),

        child: SizedBox(
          height: 52,
          width: double.infinity,

          child: ElevatedButton.icon(
            onPressed: () {
              showModalBottomSheet(
                context: context,
                isScrollControlled: true,
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
                ),
                builder: (_) => AddMedicineSheet(
                  medicineId: medicine.id,
                  brand: medicine.brand,
                ),
              );
            },

            icon: const Icon(Icons.add),

            label: Text(
              t.addMedicine,
              style: const TextStyle(fontWeight: FontWeight.w700),
            ),

            style: ElevatedButton.styleFrom(
              backgroundColor: WellnessColors.primary,
              foregroundColor: Colors.white,

              elevation: 0,

              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(16),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
