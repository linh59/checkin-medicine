import 'package:flutter/material.dart';

class LanguageService extends ChangeNotifier {
  Locale _locale = const Locale('vi');

  Locale get locale => _locale;

  void changeLanguage(String code) {
    _locale = Locale(code);
    notifyListeners();
  }
}