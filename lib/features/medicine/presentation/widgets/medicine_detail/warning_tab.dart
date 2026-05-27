import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../l10n/app_localizations.dart';
import '../../../data/models/medicine_detail_model.dart';

class WarningsTab
    extends StatelessWidget {
  final MedicineDetailModel
  medicine;

  const WarningsTab({
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

    if (medicine
        .warnings
        .isEmpty) {
      return Center(
        child: Text(
          t.noWarnings,
        ),
      );
    }

    return ListView.separated(
      itemCount:
      medicine
          .warnings
          .length,
      separatorBuilder:
          (_, __) =>
      const SizedBox(
        height: 12,
      ),
      itemBuilder:
          (
          context,
          index,
          ) {
        return Container(
          padding:
          const EdgeInsets.all(
            16,
          ),
          decoration:
          BoxDecoration(
            color: Colors.orange
                .withOpacity(
              0.1,
            ),
            borderRadius:
            BorderRadius.circular(
              18,
            ),
          ),
          child:
          Row(
            crossAxisAlignment:
            CrossAxisAlignment
                .start,
            children: [
              const Icon(
                Icons.warning_amber,
                color:
                Colors.orange,
              ),

              const SizedBox(
                width:
                10,
              ),

              Expanded(
                child:
                Text(
                  medicine
                      .warnings[index],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

