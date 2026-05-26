import 'package:checkin_medicine/core/services/auth_gate.dart';
import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import '../../../core/services/auth_service.dart';
import '../../../l10n/app_localizations.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
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

      // 📧 EMAIL
      if (email.isEmpty) {
        emailError = t.emailRequired;
        ok = false;
      } else if (!email.contains("@")) {
        emailError = t.invalidEmail;
        ok = false;
      }

      // 🔒 PASSWORD
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

  Future<void> signup(AppLocalizations t) async {
    if (!validate(t)) return;

    setState(() => loading = true);

    try {
      final res = await auth.signUp(
        email: emailCtrl.text.trim(),
        password: passCtrl.text.trim(),
      );

      if (res.user != null && mounted) {
        Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(builder: (_) => const AuthGate()),
              (route) => false,
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

                  // 🌿 ICON
                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: WellnessColors.primary.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.person_add,
                      size: 40,
                      color: WellnessColors.primary,
                    ),
                  ),

                  const SizedBox(height: 16),

                  // TITLE
                  Text(
                    t.createAccount,
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
                      onPressed: loading ? null : () => signup(t),
                      child: loading
                          ? const SizedBox(
                        height: 18,
                        width: 18,
                        child: CircularProgressIndicator(
                          strokeWidth: 2,
                          color: Colors.white,
                        ),
                      )
                          : Text(t.createAccount),
                    ),
                  ),

                  const SizedBox(height: 12),

                  // BACK TO LOGIN
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      t.login,
                      style: const TextStyle(
                        color: WellnessColors.primary,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}