import 'package:flutter/material.dart';

import '../../../../core/services/language_service.dart';
import '../../../../l10n/app_localizations.dart';

class HomePage extends StatelessWidget {
  final LanguageService languageService;

  const HomePage({
    super.key,
    required this.languageService,
  });

  @override
  Widget build(BuildContext context) {
    final l10n =
    AppLocalizations.of(context)!;

    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.home),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Text(
              l10n.home,
              style: const TextStyle(
                fontSize: 24,
              ),
            ),

            const SizedBox(height: 20),

            DropdownButton<String>(
              value:
              languageService.locale.languageCode,

              items: const [
                DropdownMenuItem(
                  value: 'vi',
                  child: Text('Tiếng Việt'),
                ),
                DropdownMenuItem(
                  value: 'en',
                  child: Text('English'),
                ),
              ],

              onChanged: (value) {
                if (value != null) {
                  languageService
                      .changeLanguage(value);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}