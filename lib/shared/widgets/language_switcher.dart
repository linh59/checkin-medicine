import 'package:checkin_medicine/core/services/language_service.dart';
import 'package:flutter/material.dart';

class LanguageSwitcher extends StatelessWidget {
  LanguageSwitcher({super.key});

  final languageService = LanguageService();

  @override
  Widget build(BuildContext context) {
    return DropdownButton<String>(
      value: languageService.locale.languageCode,
      items: const [
        DropdownMenuItem(
          value: 'vi',
          child: Text('🇻🇳 Tiếng Việt'),
        ),
        DropdownMenuItem(
          value: 'en',
          child: Text('🇬🇧 English'),
        ),
      ],
      onChanged: (value) {
        if (value != null) {
          languageService.changeLanguage(value);
        }
      },
    );
  }
}