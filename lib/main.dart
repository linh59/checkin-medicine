import 'package:flutter/material.dart';
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

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: Scaffold(
        body: Center(
          child: Text('Connected'),
        ),
      ),
    );
  }
}