import 'package:checkin_medicine/features/nutrient/data/models/nutrient_safe_limit_model.dart';

import '../../../../l10n/app_localizations.dart';

extension NutrientSafeLimitX on NutrientSafeLimitModel {
  String genderText(AppLocalizations t) {
    switch (sex?.toLowerCase()) {
      case 'male':
        return t.male;

      case 'female':
        return t.female;

      default:
        return '';
    }
  }

  String lifeStageText(AppLocalizations t) {
    switch (lifeStage?.toLowerCase()) {
      case 'pregnant':
        return t.pregnant;

      case 'lactation':
        return t.breastfeeding;

      default:
        return lifeStage ?? '';
    }
  }

  String ageRangeText(AppLocalizations t) {
    if (ageMinMonths == null || ageMaxMonths == null) {
      return '';
    }

    final min = ageMinMonths!;
    final max = ageMaxMonths!;

    if (max < 12) {
      return '$min-${max}${t.months}';
    }

    return '${(min / 12).round()}-${(max / 12).round()} ${t.yearsOld}';
  }
}
