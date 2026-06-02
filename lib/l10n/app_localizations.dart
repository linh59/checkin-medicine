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

  /// No description provided for @nutrientNotFound.
  ///
  /// In en, this message translates to:
  /// **'Nutrient not found'**
  String get nutrientNotFound;

  /// No description provided for @safeDoseByGroup.
  ///
  /// In en, this message translates to:
  /// **'Safe dosage by group'**
  String get safeDoseByGroup;

  /// No description provided for @commonForms.
  ///
  /// In en, this message translates to:
  /// **'Common forms'**
  String get commonForms;

  /// No description provided for @whyImportant.
  ///
  /// In en, this message translates to:
  /// **'Why it matters'**
  String get whyImportant;

  /// No description provided for @noData.
  ///
  /// In en, this message translates to:
  /// **'No data available'**
  String get noData;

  /// No description provided for @rda.
  ///
  /// In en, this message translates to:
  /// **'RDA'**
  String get rda;

  /// No description provided for @ul.
  ///
  /// In en, this message translates to:
  /// **'UL'**
  String get ul;

  /// No description provided for @groupAdultMale.
  ///
  /// In en, this message translates to:
  /// **'Adult Male'**
  String get groupAdultMale;

  /// No description provided for @groupAdultFemale.
  ///
  /// In en, this message translates to:
  /// **'Adult Female'**
  String get groupAdultFemale;

  /// No description provided for @groupPregnant.
  ///
  /// In en, this message translates to:
  /// **'Pregnant'**
  String get groupPregnant;

  /// No description provided for @groupBreastfeeding.
  ///
  /// In en, this message translates to:
  /// **'Breastfeeding'**
  String get groupBreastfeeding;

  /// No description provided for @groupChild.
  ///
  /// In en, this message translates to:
  /// **'Child'**
  String get groupChild;

  /// No description provided for @groupTeen.
  ///
  /// In en, this message translates to:
  /// **'Teenager'**
  String get groupTeen;

  /// No description provided for @groupSenior.
  ///
  /// In en, this message translates to:
  /// **'Senior'**
  String get groupSenior;

  /// No description provided for @vitamin.
  ///
  /// In en, this message translates to:
  /// **'Vitamin'**
  String get vitamin;

  /// No description provided for @mineral.
  ///
  /// In en, this message translates to:
  /// **'Mineral'**
  String get mineral;

  /// No description provided for @aminoAcid.
  ///
  /// In en, this message translates to:
  /// **'Amino Acid'**
  String get aminoAcid;

  /// No description provided for @herb.
  ///
  /// In en, this message translates to:
  /// **'Herb'**
  String get herb;

  /// No description provided for @adultMale.
  ///
  /// In en, this message translates to:
  /// **'Adult Male'**
  String get adultMale;

  /// No description provided for @adultFemale.
  ///
  /// In en, this message translates to:
  /// **'Adult Female'**
  String get adultFemale;

  /// No description provided for @pregnant.
  ///
  /// In en, this message translates to:
  /// **'Pregnant'**
  String get pregnant;

  /// No description provided for @child.
  ///
  /// In en, this message translates to:
  /// **'Child'**
  String get child;

  /// No description provided for @safeDosageByGroup.
  ///
  /// In en, this message translates to:
  /// **'Safe dosage by group'**
  String get safeDosageByGroup;

  /// No description provided for @usedInMedicine.
  ///
  /// In en, this message translates to:
  /// **'Used in medicine'**
  String get usedInMedicine;

  /// No description provided for @benefits.
  ///
  /// In en, this message translates to:
  /// **'Benefits'**
  String get benefits;

  /// No description provided for @sideEffects.
  ///
  /// In en, this message translates to:
  /// **'Side Effects'**
  String get sideEffects;

  /// No description provided for @bestTakenWith.
  ///
  /// In en, this message translates to:
  /// **'Best taken with'**
  String get bestTakenWith;

  /// No description provided for @avoidWith.
  ///
  /// In en, this message translates to:
  /// **'Avoid combining with'**
  String get avoidWith;

  /// No description provided for @notes.
  ///
  /// In en, this message translates to:
  /// **'Note'**
  String get notes;

  /// No description provided for @noResults.
  ///
  /// In en, this message translates to:
  /// **'No results found'**
  String get noResults;

  /// No description provided for @salt.
  ///
  /// In en, this message translates to:
  /// **'Salt form'**
  String get salt;

  /// No description provided for @interactions.
  ///
  /// In en, this message translates to:
  /// **'Known interactions'**
  String get interactions;

  /// No description provided for @noInteractions.
  ///
  /// In en, this message translates to:
  /// **'No significant interactions recorded'**
  String get noInteractions;

  /// No description provided for @interactionWith.
  ///
  /// In en, this message translates to:
  /// **'Interaction with {name}'**
  String interactionWith(Object name);

  /// No description provided for @severityLow.
  ///
  /// In en, this message translates to:
  /// **'Mild'**
  String get severityLow;

  /// No description provided for @severityMedium.
  ///
  /// In en, this message translates to:
  /// **'Moderate'**
  String get severityMedium;

  /// No description provided for @severityHigh.
  ///
  /// In en, this message translates to:
  /// **'Severe'**
  String get severityHigh;

  /// No description provided for @recommendation.
  ///
  /// In en, this message translates to:
  /// **'Recommendation'**
  String get recommendation;

  /// No description provided for @adult.
  ///
  /// In en, this message translates to:
  /// **'Adult'**
  String get adult;

  /// No description provided for @senior.
  ///
  /// In en, this message translates to:
  /// **'Senior'**
  String get senior;

  /// No description provided for @reminders.
  ///
  /// In en, this message translates to:
  /// **'Reminders'**
  String get reminders;

  /// No description provided for @darkMode.
  ///
  /// In en, this message translates to:
  /// **'Dark Mode'**
  String get darkMode;

  /// No description provided for @security.
  ///
  /// In en, this message translates to:
  /// **'Security'**
  String get security;

  /// No description provided for @comingSoon.
  ///
  /// In en, this message translates to:
  /// **'Coming Soon'**
  String get comingSoon;

  /// No description provided for @logout.
  ///
  /// In en, this message translates to:
  /// **'Log Out'**
  String get logout;

  /// No description provided for @myMedicineCabinet.
  ///
  /// In en, this message translates to:
  /// **'Medicine Cabinet'**
  String get myMedicineCabinet;

  /// No description provided for @noMedicinesYet.
  ///
  /// In en, this message translates to:
  /// **'No medicines yet'**
  String get noMedicinesYet;

  /// No description provided for @addMedicineDescription.
  ///
  /// In en, this message translates to:
  /// **'Add medicines or supplements to create reminders and safety checks automatically.'**
  String get addMedicineDescription;

  /// No description provided for @add_medicine_title.
  ///
  /// In en, this message translates to:
  /// **'Add {brand}'**
  String add_medicine_title(Object brand);

  /// No description provided for @nickname.
  ///
  /// In en, this message translates to:
  /// **'Nickname (optional)'**
  String get nickname;

  /// No description provided for @nicknameHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. Morning calcium'**
  String get nicknameHint;

  /// No description provided for @notesHint.
  ///
  /// In en, this message translates to:
  /// **'e.g. 1 tablet after breakfast'**
  String get notesHint;

  /// No description provided for @saveToMyMedicine.
  ///
  /// In en, this message translates to:
  /// **'Save to my medicines'**
  String get saveToMyMedicine;

  /// No description provided for @addMedicineSuccess.
  ///
  /// In en, this message translates to:
  /// **'Medicine added successfully'**
  String get addMedicineSuccess;

  /// No description provided for @noProfile.
  ///
  /// In en, this message translates to:
  /// **'No active profile'**
  String get noProfile;

  /// No description provided for @active.
  ///
  /// In en, this message translates to:
  /// **'Running'**
  String get active;

  /// No description provided for @paused.
  ///
  /// In en, this message translates to:
  /// **'Paused'**
  String get paused;

  /// No description provided for @noTimeline.
  ///
  /// In en, this message translates to:
  /// **'No timeline yet'**
  String get noTimeline;

  /// No description provided for @createTimelineHint.
  ///
  /// In en, this message translates to:
  /// **'Create a schedule to manage your medicine'**
  String get createTimelineHint;

  /// No description provided for @safety.
  ///
  /// In en, this message translates to:
  /// **'Safety'**
  String get safety;

  /// No description provided for @status.
  ///
  /// In en, this message translates to:
  /// **'Status'**
  String get status;

  /// No description provided for @beforeMeal.
  ///
  /// In en, this message translates to:
  /// **'Before meal'**
  String get beforeMeal;

  /// No description provided for @afterMeal.
  ///
  /// In en, this message translates to:
  /// **'After meal'**
  String get afterMeal;

  /// No description provided for @withMeal.
  ///
  /// In en, this message translates to:
  /// **'With meal'**
  String get withMeal;

  /// No description provided for @pillCount.
  ///
  /// In en, this message translates to:
  /// **'{count} pill(s)'**
  String pillCount(int count);

  /// No description provided for @noScheduleYet.
  ///
  /// In en, this message translates to:
  /// **'No schedule yet'**
  String get noScheduleYet;

  /// No description provided for @pills.
  ///
  /// In en, this message translates to:
  /// **'pill(s)'**
  String get pills;

  /// No description provided for @dose.
  ///
  /// In en, this message translates to:
  /// **'Dose'**
  String get dose;

  /// No description provided for @editSchedule.
  ///
  /// In en, this message translates to:
  /// **'Edit Schedule'**
  String get editSchedule;

  /// No description provided for @time.
  ///
  /// In en, this message translates to:
  /// **'Time'**
  String get time;

  /// No description provided for @withFood.
  ///
  /// In en, this message translates to:
  /// **'With food'**
  String get withFood;

  /// No description provided for @save.
  ///
  /// In en, this message translates to:
  /// **'Save'**
  String get save;

  /// No description provided for @delete.
  ///
  /// In en, this message translates to:
  /// **'Delete'**
  String get delete;

  /// No description provided for @cancel.
  ///
  /// In en, this message translates to:
  /// **'Cancel'**
  String get cancel;

  /// No description provided for @confirmDelete.
  ///
  /// In en, this message translates to:
  /// **'Delete this schedule?'**
  String get confirmDelete;

  /// No description provided for @addToPlan.
  ///
  /// In en, this message translates to:
  /// **'Add to Plan'**
  String get addToPlan;

  /// No description provided for @add.
  ///
  /// In en, this message translates to:
  /// **'Add'**
  String get add;

  /// No description provided for @withFoodHint.
  ///
  /// In en, this message translates to:
  /// **'Before/after meal 30 mins...'**
  String get withFoodHint;

  /// No description provided for @selectMedicine.
  ///
  /// In en, this message translates to:
  /// **'Please select a medicine'**
  String get selectMedicine;
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
