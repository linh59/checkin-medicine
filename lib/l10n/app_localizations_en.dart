// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get home => 'Home';

  @override
  String get medicine => 'Medicine';

  @override
  String get today => 'Today';

  @override
  String get loginTitle => 'Welcome Back';

  @override
  String get email => 'Email';

  @override
  String get password => 'Password';

  @override
  String get login => 'Login';

  @override
  String get createAccount => 'Create account';

  @override
  String get loginSuccess => 'Login successful';

  @override
  String get loginFailed => 'Login failed';

  @override
  String get signupTitle => 'Create Account';

  @override
  String get signupSuccess => 'Account created successfully';

  @override
  String get signupFailed => 'Signup failed';

  @override
  String get invalidEmail => 'Invalid email format';

  @override
  String get emailRequired => 'Email is required';

  @override
  String get passwordRequired => 'Password is required';

  @override
  String get passwordMin => 'Minimum 6 characters';

  @override
  String get loginSubtitle => 'Manage your medication safely';

  @override
  String get schedule => 'Schedule';

  @override
  String get stats => 'Statistics';

  @override
  String get family => 'Family';

  @override
  String get settings => 'Settings';

  @override
  String get homeGreeting => 'Hello';

  @override
  String get todayScheduleSubtitle =>
      'Here is your medication schedule for today.';

  @override
  String get addMedicine => 'Add medicine';

  @override
  String get pharmacy => 'Medicine cabinet';

  @override
  String get createSchedule => 'Create schedule';

  @override
  String get todaySafetySummary => 'No dangerous interactions detected today.';

  @override
  String get todayCheckin => 'Today';

  @override
  String get manage => 'Manage';
}
