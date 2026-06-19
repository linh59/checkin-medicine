import 'package:checkin_medicine/core/theme/app_colors.dart';
import 'package:checkin_medicine/features/auth/presentation/providers/auth_provider.dart';
import 'package:checkin_medicine/l10n/app_localizations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/services/auth_service.dart';

class SignupPage extends ConsumerStatefulWidget {
  const SignupPage({super.key});

  @override
  ConsumerState<SignupPage> createState() => _SignupPageState();
}
class _SignupPageState
    extends ConsumerState<SignupPage> {
  final displayNameCtrl =
  TextEditingController();

  final emailCtrl =
  TextEditingController();

  final passCtrl =
  TextEditingController();

  final auth =
      AuthService.instance;

  bool loading = false;

  bool obscurePassword = true;

  String? displayNameError;
  String? emailError;
  String? passError;


  @override
  void dispose() {
    emailCtrl.dispose();
    passCtrl.dispose();
    displayNameCtrl.dispose();

    super.dispose();
  }

  bool validate(
      AppLocalizations t,
      ) {
    bool ok = true;

    setState(() {
      displayNameError = null;
      emailError = null;
      passError = null;

      final displayName =
      displayNameCtrl.text.trim();
      final email =
      emailCtrl.text.trim();

      final pass =
      passCtrl.text.trim();

      /// Display name
      if (displayName.isEmpty) {
        displayNameError =
            t.passwordRequired;
        ok = false;
      }
      /// EMAIL
      if (email.isEmpty) {
        emailError =
            t.emailRequired;
        ok = false;
      } else if (!email
          .contains("@")) {
        emailError =
            t.invalidEmail;
        ok = false;
      }

      /// PASSWORD
      if (pass.isEmpty) {
        passError =
            t.passwordRequired;
        ok = false;
      } else if (pass.length <
          6) {
        passError =
            t.passwordMin;
        ok = false;
      }
    });

    return ok;
  }

  Future<void> signup(AppLocalizations t) async {
    FocusScope.of(context).unfocus();

    if (!validate(t)) return;

    setState(() => loading = true);

    try {
      await ref.read(authProvider.notifier).signUp(
        emailCtrl.text.trim(),
        passCtrl.text.trim(),
        displayNameCtrl.text.trim(),
      );

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(t.signupSuccessMessage),
          backgroundColor: Colors.green,
        ),
      );

      Navigator.pop(context);
    } catch (e) {
      if (!mounted) return;

      setState(() {
        passError = t.signupFailedMessage;
      });

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(t.signupFailed),
          backgroundColor: Colors.red,
        ),
      );
    } finally {
      if (!mounted) return;
      setState(() => loading = false);
    }
  }
  @override
  Widget build(
      BuildContext context,
      ) {
    final t =
    AppLocalizations.of(
      context,
    )!;

    final theme =
    Theme.of(context);

    return GestureDetector(
      onTap: () {
        FocusScope.of(
          context,
        ).unfocus();
      },
      child: Scaffold(
        backgroundColor:
        theme
            .scaffoldBackgroundColor,
        body: SafeArea(
          child: Center(
            child:
            SingleChildScrollView(
              padding:
              const EdgeInsets.symmetric(
                horizontal: 24,
              ),
              child:
              ConstrainedBox(
                constraints:
                const BoxConstraints(
                  maxWidth: 420,
                ),
                child: Column(
                  children: [
                    /// ICON
                    Container(
                      padding:
                      const EdgeInsets.all(
                        16,
                      ),
                      decoration:
                      BoxDecoration(
                        color:
                        WellnessColors
                            .primary
                            .withOpacity(
                          0.1,
                        ),
                        shape:
                        BoxShape.circle,
                      ),
                      child:
                      const Icon(
                        Icons.person_add,
                        size: 40,
                        color:
                        WellnessColors
                            .primary,
                      ),
                    ),

                    const SizedBox(
                      height: 16,
                    ),

                    /// TITLE
                    Text(
                      t.createAccount,
                      style: theme
                          .textTheme
                          .headlineSmall
                          ?.copyWith(
                        fontWeight:
                        FontWeight
                            .bold,
                      ),
                    ),

                    const SizedBox(
                      height: 6,
                    ),

                    Text(
                      t.loginSubtitle,
                      textAlign:
                      TextAlign
                          .center,
                      style: theme
                          .textTheme
                          .bodyMedium
                          ?.copyWith(
                        color:
                        Colors.grey,
                      ),
                    ),

                    const SizedBox(
                      height: 28,
                    ),

                    /// Display name
                    TextField(
                      controller:
                      displayNameCtrl,

                      textInputAction:
                      TextInputAction
                          .next,

                      decoration:
                      InputDecoration(
                        labelText:
                        t.fullName,
                        errorText:
                        displayNameError,
                        prefixIcon:
                        const Icon(
                          Icons
                              .person_2_outlined,
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    /// EMAIL
                    TextField(
                      controller:
                      emailCtrl,
                      keyboardType:
                      TextInputType
                          .emailAddress,
                      textInputAction:
                      TextInputAction
                          .next,
                      autofillHints:
                      const [
                        AutofillHints
                            .email,
                      ],
                      decoration:
                      InputDecoration(
                        labelText:
                        t.email,
                        errorText:
                        emailError,
                        prefixIcon:
                        const Icon(
                          Icons
                              .email_outlined,
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 14,
                    ),

                    /// PASSWORD
                    TextField(
                      controller:
                      passCtrl,
                      obscureText:
                      obscurePassword,
                      textInputAction:
                      TextInputAction
                          .done,
                      autofillHints:
                      const [
                        AutofillHints
                            .newPassword,
                      ],
                      onSubmitted:
                          (_) =>
                          signup(
                            t,
                          ),
                      decoration:
                      InputDecoration(
                        labelText:
                        t.password,
                        errorText:
                        passError,
                        prefixIcon:
                        const Icon(
                          Icons
                              .lock_outline,
                        ),

                        /// SHOW / HIDE
                        suffixIcon:
                        IconButton(
                          onPressed:
                              () {
                            setState(
                                  () {
                                obscurePassword =
                                !obscurePassword;
                              },
                            );
                          },
                          icon:
                          Icon(
                            obscurePassword
                                ? Icons
                                .visibility_off_outlined
                                : Icons
                                .visibility_outlined,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 20,
                    ),

                    /// SIGNUP BUTTON
                    SizedBox(
                      width: double.infinity,
                      height: 52,
                      child:
                      ElevatedButton(
                        onPressed:
                        loading
                            ? null
                            : () =>
                            signup(
                              t,
                            ),
                        child:
                        loading
                            ? const SizedBox(
                          height:
                          18,
                          width:
                          18,
                          child:
                          CircularProgressIndicator(
                            strokeWidth:
                            2,
                            color:
                            Colors.white,
                          ),
                        )
                            : Text(
                          t.createAccount,
                        ),
                      ),
                    ),

                    const SizedBox(
                      height: 12,
                    ),

                    /// BACK TO LOGIN
                    TextButton(
                      onPressed:
                          () =>
                          Navigator.pop(
                            context,
                          ),
                      child: Text(
                        t.login,
                        style:
                        const TextStyle(
                          color:
                          WellnessColors
                              .primary,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}