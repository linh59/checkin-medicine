import 'package:checkin_medicine/l10n/app_localizations.dart';

extension MedicineFormLocalization on String {
  String localized(AppLocalizations t) {
    switch (this) {
      case 'tablet':
        return t.tablet;
      case 'capsule':
        return t.capsule;
      case 'softgel':
        return t.softgel;
      case 'powder':
        return t.powder;
      case 'effervescent':
        return t.effervescent;
      default:
        return this;
    }
  }
}