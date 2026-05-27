import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../l10n/app_localizations.dart';
import '../../../data/models/medicine_detail_model.dart';


class BottomAction
    extends StatelessWidget {
  final MedicineDetailModel
  medicine;

  const BottomAction({
    required this.medicine,
  });

  @override
  Widget build(
      BuildContext context,
      ) {
    final t =
    AppLocalizations.of(
      context,
    )!;

    return SafeArea(
      top: false,
      child: Container(
        padding:
        const EdgeInsets.all(
          16,
        ),
        decoration:
        BoxDecoration(
          color: Theme.of(
            context,
          ).scaffoldBackgroundColor,
          border: Border(
            top: BorderSide(
              color: Colors
                  .grey
                  .withOpacity(
                0.2,
              ),
            ),
          ),
        ),
        child: SizedBox(
          width:
          double.infinity,
          height:
          54,
          child:
          ElevatedButton.icon(
            onPressed:
                () {
              // TODO:
              // AddMedicineSheet
            },
            icon:
            const Icon(
              Icons.add,
            ),
            label: Text(
              t.addMedicine,
            ),
          ),
        ),
      ),
    );
  }
}