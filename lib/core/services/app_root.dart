import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../features/auth/presentation/pages/login_page.dart';
import '../../features/auth/presentation/pages/splash_page.dart';
import '../../features/auth/presentation/providers/auth_provider.dart';


import '../../features/home/widgets/home_shell.dart';


class AppRoot extends ConsumerWidget {
  const AppRoot({super.key});

  @override
  Widget build(
      BuildContext context,
      WidgetRef ref,
      ) {
    final auth = ref.watch(authProvider);

    /// Loading auth state
    if (auth.loading) {
      return const SplashPage();
    }

    /// Not logged in
    if (auth.session == null || auth.user == null) {
      return const LoginPage();
    }

    /// Logged in
    return const HomeShell();
  }
}