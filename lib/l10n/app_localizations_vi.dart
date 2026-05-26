// ignore: unused_import
import 'package:intl/intl.dart' as intl;
import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for Vietnamese (`vi`).
class AppLocalizationsVi extends AppLocalizations {
  AppLocalizationsVi([String locale = 'vi']) : super(locale);

  @override
  String get home => 'Trang chủ';

  @override
  String get medicine => 'Thuốc';

  @override
  String get today => 'Hôm nay';

  @override
  String get loginTitle => 'Chào mừng trở lại';

  @override
  String get email => 'Email';

  @override
  String get password => 'Mật khẩu';

  @override
  String get login => 'Đăng nhập';

  @override
  String get createAccount => 'Tạo tài khoản';

  @override
  String get loginSuccess => 'Đăng nhập thành công';

  @override
  String get loginFailed => 'Đăng nhập thất bại';

  @override
  String get signupTitle => 'Tạo tài khoản';

  @override
  String get signupSuccess => 'Tạo tài khoản thành công';

  @override
  String get signupFailed => 'Tạo tài khoản thất bại';

  @override
  String get invalidEmail => 'Email không hợp lệ';

  @override
  String get emailRequired => 'Vui lòng nhập email';

  @override
  String get passwordRequired => 'Vui lòng nhập mật khẩu';

  @override
  String get passwordMin => 'Tối thiểu 6 ký tự';

  @override
  String get loginSubtitle => 'Quản lý thuốc của bạn an toàn mỗi ngày';
}
