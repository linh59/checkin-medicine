import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_vi.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'l10n/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale)
    : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  static const LocalizationsDelegate<AppLocalizations> delegate =
      _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates =
      <LocalizationsDelegate<dynamic>>[
        delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
      ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('vi'),
  ];

  /// No description provided for @home.
  ///
  /// In en, this message translates to:
  /// **'Home'**
  String get home;

  /// No description provided for @medicine.
  ///
  /// In en, this message translates to:
  /// **'Medicine'**
  String get medicine;

  /// No description provided for @today.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get today;

  /// No description provided for @loginTitle.
  ///
  /// In en, this message translates to:
  /// **'Welcome Back'**
  String get loginTitle;

  /// No description provided for @email.
  ///
  /// In en, this message translates to:
  /// **'Email'**
  String get email;

  /// No description provided for @password.
  ///
  /// In en, this message translates to:
  /// **'Password'**
  String get password;

  /// No description provided for @login.
  ///
  /// In en, this message translates to:
  /// **'Login'**
  String get login;

  /// No description provided for @createAccount.
  ///
  /// In en, this message translates to:
  /// **'Create account'**
  String get createAccount;

  /// No description provided for @loginSuccess.
  ///
  /// In en, this message translates to:
  /// **'Login successful'**
  String get loginSuccess;

  /// No description provided for @loginFailed.
  ///
  /// In en, this message translates to:
  /// **'Login failed'**
  String get loginFailed;

  /// No description provided for @signupTitle.
  ///
  /// In en, this message translates to:
  /// **'Create Account'**
  String get signupTitle;

  /// No description provided for @signupSuccess.
  ///
  /// In en, this message translates to:
  /// **'Account created successfully'**
  String get signupSuccess;

  /// No description provided for @signupFailed.
  ///
  /// In en, this message translates to:
  /// **'Signup failed'**
  String get signupFailed;

  /// No description provided for @invalidEmail.
  ///
  /// In en, this message translates to:
  /// **'Invalid email format'**
  String get invalidEmail;

  /// No description provided for @emailRequired.
  ///
  /// In en, this message translates to:
  /// **'Email is required'**
  String get emailRequired;

  /// No description provided for @passwordRequired.
  ///
  /// In en, this message translates to:
  /// **'Password is required'**
  String get passwordRequired;

  /// No description provided for @passwordMin.
  ///
  /// In en, this message translates to:
  /// **'Minimum 6 characters'**
  String get passwordMin;

  /// No description provided for @loginSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Manage your medication safely'**
  String get loginSubtitle;

  /// No description provided for @schedule.
  ///
  /// In en, this message translates to:
  /// **'Schedule'**
  String get schedule;

  /// No description provided for @stats.
  ///
  /// In en, this message translates to:
  /// **'Statistics'**
  String get stats;

  /// No description provided for @family.
  ///
  /// In en, this message translates to:
  /// **'Family'**
  String get family;

  /// No description provided for @settings.
  ///
  /// In en, this message translates to:
  /// **'Settings'**
  String get settings;

  /// No description provided for @homeGreeting.
  ///
  /// In en, this message translates to:
  /// **'Hello'**
  String get homeGreeting;

  /// No description provided for @todayScheduleSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Here is your medication schedule for today.'**
  String get todayScheduleSubtitle;

  /// No description provided for @addMedicine.
  ///
  /// In en, this message translates to:
  /// **'Add medicine'**
  String get addMedicine;

  /// No description provided for @pharmacy.
  ///
  /// In en, this message translates to:
  /// **'Medicine cabinet'**
  String get pharmacy;

  /// No description provided for @createSchedule.
  ///
  /// In en, this message translates to:
  /// **'Create schedule'**
  String get createSchedule;

  /// No description provided for @todaySafetySummary.
  ///
  /// In en, this message translates to:
  /// **'No dangerous interactions detected today.'**
  String get todaySafetySummary;

  /// No description provided for @todayCheckin.
  ///
  /// In en, this message translates to:
  /// **'Today'**
  String get todayCheckin;

  /// No description provided for @manage.
  ///
  /// In en, this message translates to:
  /// **'Manage'**
  String get manage;

  /// No description provided for @searchTitle.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get searchTitle;

  /// No description provided for @searchSubtitle.
  ///
  /// In en, this message translates to:
  /// **'Find medicines, vitamins or ingredients'**
  String get searchSubtitle;

  /// No description provided for @searchPlaceholder.
  ///
  /// In en, this message translates to:
  /// **'Magnesium, Caltrate, Centrum…'**
  String get searchPlaceholder;

  /// No description provided for @myMedicines.
  ///
  /// In en, this message translates to:
  /// **'My medicines'**
  String get myMedicines;

  /// No description provided for @createMedicine.
  ///
  /// In en, this message translates to:
  /// **'Create medicine'**
  String get createMedicine;

  /// No description provided for @medicineAndVitamin.
  ///
  /// In en, this message translates to:
  /// **'Medicine & Vitamins'**
  String get medicineAndVitamin;

  /// No description provided for @ingredients.
  ///
  /// In en, this message translates to:
  /// **'Ingredients'**
  String get ingredients;

  /// No description provided for @noMedicineFound.
  ///
  /// In en, this message translates to:
  /// **'No medicines found'**
  String get noMedicineFound;

  /// No description provided for @noIngredientFound.
  ///
  /// In en, this message translates to:
  /// **'No ingredients found'**
  String get noIngredientFound;

  /// No description provided for @tryAnotherKeyword.
  ///
  /// In en, this message translates to:
  /// **'Try another keyword like \"magnesium\", \"centrum\"…'**
  String get tryAnotherKeyword;

  /// No description provided for @brand.
  ///
  /// In en, this message translates to:
  /// **'Brand'**
  String get brand;

  /// No description provided for @manufacturer.
  ///
  /// In en, this message translates to:
  /// **'Manufacturer'**
  String get manufacturer;

  /// No description provided for @genericName.
  ///
  /// In en, this message translates to:
  /// **'Active ingredient'**
  String get genericName;

  /// No description provided for @unknown.
  ///
  /// In en, this message translates to:
  /// **'Unknown'**
  String get unknown;

  /// No description provided for @searchLoading.
  ///
  /// In en, this message translates to:
  /// **'Searching...'**
  String get searchLoading;

  /// No description provided for @medicineCabinet.
  ///
  /// In en, this message translates to:
  /// **'Medicine cabinet'**
  String get medicineCabinet;

  /// No description provided for @medicines.
  ///
  /// In en, this message translates to:
  /// **'Thuốc & Vitamin'**
  String get medicines;

  /// No description provided for @nutrients.
  ///
  /// In en, this message translates to:
  /// **'Thành phần'**
  String get nutrients;

  /// No description provided for @search.
  ///
  /// In en, this message translates to:
  /// **'Search'**
  String get search;

  /// No description provided for @searchHint.
  ///
  /// In en, this message translates to:
  /// **'Magnesium, Caltrate, Centrum...'**
  String get searchHint;

  /// No description provided for @overview.
  ///
  /// In en, this message translates to:
  /// **'Overview'**
  String get overview;

  /// No description provided for @warnings.
  ///
  /// In en, this message translates to:
  /// **'Warnings'**
  String get warnings;

  /// No description provided for @description.
  ///
  /// In en, this message translates to:
  /// **'Description'**
  String get description;

  /// No description provided for @ingredientSummary.
  ///
  /// In en, this message translates to:
  /// **'Ingredient Summary'**
  String get ingredientSummary;

  /// No description provided for @notFound.
  ///
  /// In en, this message translates to:
  /// **'Not Found'**
  String get notFound;

  /// No description provided for @medicineNotFound.
  ///
  /// In en, this message translates to:
  /// **'Medicine not found'**
  String get medicineNotFound;

  /// No description provided for @backToSearch.
  ///
  /// In en, this message translates to:
  /// **'Back to Search'**
  String get backToSearch;

  /// No description provided for @noWarnings.
  ///
  /// In en, this message translates to:
  /// **'No special warnings'**
  String get noWarnings;

  /// No description provided for @absorption.
  ///
  /// In en, this message translates to:
  /// **'Absorption'**
  String get absorption;

  /// No description provided for @tablet.
  ///
  /// In en, this message translates to:
  /// **'Tablet'**
  String get tablet;

  /// No description provided for @capsule.
  ///
  /// In en, this message translates to:
  /// **'Capsule'**
  String get capsule;

  /// No description provided for @softgel.
  ///
  /// In en, this message translates to:
  /// **'Softgel'**
  String get softgel;

  /// No description provided for @powder.
  ///
  /// In en, this message translates to:
  /// **'Powder'**
  String get powder;

  /// No description provided for @liquid.
  ///
  /// In en, this message translates to:
  /// **'Liquid'**
  String get liquid;

  /// No description provided for @drops.
  ///
  /// In en, this message translates to:
  /// **'Drops'**
  String get drops;

  /// No description provided for @spray.
  ///
  /// In en, this message translates to:
  /// **'Spray'**
  String get spray;

  /// No description provided for @cream.
  ///
  /// In en, this message translates to:
  /// **'Cream'**
  String get cream;

  /// No description provided for @ointment.
  ///
  /// In en, this message translates to:
  /// **'Ointment'**
  String get ointment;

  /// No description provided for @injection.
  ///
  /// In en, this message translates to:
  /// **'Injection'**
  String get injection;

  /// No description provided for @dailyValue.
  ///
  /// In en, this message translates to:
  /// **'DV'**
  String get dailyValue;

  /// No description provided for @perPill.
  ///
  /// In en, this message translates to:
  /// **'pill'**
  String get perPill;
}

class _AppLocalizationsDelegate
    extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) =>
      <String>['en', 'vi'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {
  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en':
      return AppLocalizationsEn();
    case 'vi':
      return AppLocalizationsVi();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.',
  );
}
