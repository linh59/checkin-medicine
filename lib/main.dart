import 'package:checkin_medicine/core/controllers/theme_controller.dart';
import 'package:checkin_medicine/core/theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'core/services/language_service.dart';
import 'l10n/app_localizations.dart';
import 'features/auth/splash_page.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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
  void initState() {
    super.initState();
    languageService.addListener(() {
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(providers:
    [
      ChangeNotifierProvider(create: (_) => ThemeController())
    ],
    child: Consumer<ThemeController>(
        builder: (context, theme, _){
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: AppTheme.light,
            darkTheme: AppTheme.dark,
            themeMode: theme.themeMode,
            locale: languageService.locale,

            supportedLocales: const [
              Locale('vi'),
              Locale('en'),
            ],

            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],

            home: const SplashPage(),
          );
    },
    ),
    );
  }
}