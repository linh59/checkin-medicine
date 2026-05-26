import 'package:checkin_medicine/features/home/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

import 'core/services/language_service.dart';
import 'l10n/app_localizations.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: 'https://ftmluxrhhbbxalhfbdbt.supabase.co',
    anonKey: 'sb_publishable_UWcNDzQDuRALfeKx2KEeZA_LLfzH29p',
  );

  final supabase = Supabase.instance.client;

  final medicines =
  await supabase.from('medicines').select();

  print(medicines);

  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final languageService = LanguageService();

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: languageService,
      builder: (context, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,

          locale: languageService.locale,

          localizationsDelegates: const [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],

          supportedLocales: const [
            Locale('en'),
            Locale('vi'),
          ],

          home: HomePage(
            languageService: languageService,
          ),
        );
      },
    );
  }
}