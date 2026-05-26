import 'package:checkin_medicine/core/services/auth_gate.dart';
import 'package:checkin_medicine/shared/widgets/theme_switcher.dart';
import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/services/auth_service.dart';
import '../../../l10n/app_localizations.dart';
import 'signup_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final emailCtrl = TextEditingController();
  final passCtrl = TextEditingController();
  final auth = AuthService();

  bool loading = false;

  String? emailError;
  String? passError;

  bool validate(AppLocalizations t) {
    bool ok = true;

    setState(() {
      emailError = null;
      passError = null;

      final email = emailCtrl.text.trim();
      final pass = passCtrl.text.trim();

      if (email.isEmpty) {
        emailError = t.emailRequired;
        ok = false;
      } else if (!email.contains("@")) {
        emailError = t.invalidEmail;
        ok = false;
      }

      if (pass.isEmpty) {
        passError = t.passwordRequired;
        ok = false;
      } else if (pass.length < 6) {
        passError = t.passwordMin;
        ok = false;
      }
    });

    return ok;
  }

  Future<void> login(AppLocalizations t) async {
    if (!validate(t)) return;

    setState(() => loading = true);

    try {
      final res = await auth.signIn(
        email: emailCtrl.text.trim(),
        password: passCtrl.text.trim(),
      );

      if (res.user != null && mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (_) => const AuthGate()),
        );
      }
    } catch (_) {
      setState(() {
        passError = t.loginFailed;
      });
    } finally {
      if (mounted) setState(() => loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,

      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 24),

            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 420),

              child: Column(
                children: [

                  //  ICON
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: WellnessColors.primary.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.medical_services,
                      size: 40,
                      color: WellnessColors.primary,
                    ),
                  ),

                  const SizedBox(height: 16),

                  // TITLE
                  Text(
                    t.loginTitle,
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 6),

                  Text(
                    t.loginSubtitle,
                    textAlign: TextAlign.center,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      color: Colors.grey,
                    ),
                  ),

                  const SizedBox(height: 28),

                  // 📧 EMAIL
                  TextField(
                    controller: emailCtrl,
                    keyboardType: TextInputType.emailAddress,
                    decoration: InputDecoration(
                      labelText: t.email,
                      errorText: emailError,
                    ),
                  ),

                  const SizedBox(height: 14),

                  // 🔒 PASSWORD
                  TextField(
                    controller: passCtrl,
                    obscureText: true,
                    decoration: InputDecoration(
                      labelText: t.password,
                      errorText: passError,
                    ),
                  ),

                  const SizedBox(height: 20),

                  // 🔘 BUTTON
                  SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                      onPressed: loading ? null : () => login(t),
                      child: loading
                          ? const SizedBox(
                        height: 18,
                        width: 18,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                          : Text(t.login),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // SIGNUP
                  TextButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const SignupPage(),
                        ),
                      );
                    },
                    child: Text(
                      t.createAccount,
                      style: const TextStyle(
                        color: WellnessColors.primary,
                      ),
                    ),
                  ),

                  const SizedBox(height: 12),
                  const ThemeSwitcher()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}