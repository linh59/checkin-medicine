import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../../../l10n/app_localizations.dart';
import '../../../data/models/medicine_detail_model.dart';
class MedicineTabBar
    extends StatelessWidget {

  final TabController controller;

  const MedicineTabBar({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final t =
    AppLocalizations.of(context)!;

    return Container(
      height: 50,
      decoration: BoxDecoration(
        color: Theme.of(context)
            .colorScheme
            .surface,
        borderRadius:
        BorderRadius.circular(14),
      ),
      child: TabBar(
        controller: controller,
        indicator: BoxDecoration(
          color:
          WellnessColors.primary,
          borderRadius:
          BorderRadius.circular(12),
        ),
        labelColor: Colors.white,
        unselectedLabelColor:
        Colors.grey,
        dividerColor:
        Colors.transparent,
        tabs: [
          Tab(text: t.overview),
          Tab(text: t.ingredients),
          Tab(text: t.warnings),
        ],
      ),
    );
  }
}

