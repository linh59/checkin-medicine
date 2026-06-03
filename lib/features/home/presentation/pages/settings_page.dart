import 'package:checkin_medicine/features/auth/presentation/providers/auth_provider.dart';
import 'package:checkin_medicine/features/home/widgets/logout_button.dart';
import 'package:checkin_medicine/l10n/app_localizations.dart';
import 'package:checkin_medicine/shared/widgets/theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class SettingsPage extends ConsumerStatefulWidget {
  const SettingsPage({super.key});

  @override
  ConsumerState<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends ConsumerState<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final size = MediaQuery.of(context).size;

    final horizontalPadding = size.width < 600 ? 16.0 : 24.0;

    final auth = ref.watch(authProvider);
    final user = auth.user;

    return Scaffold(
      appBar: AppBar(title: Text(t.settings)),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: horizontalPadding),
          child: Column(
            children: [
              const SizedBox(height: 12),

              /// PROFILE CARD
              _ProfileCard(email: user?.email),

              const SizedBox(height: 16),

              /// SETTINGS
              _SettingItem(
                icon: Icons.dark_mode_outlined,
                label: t.darkMode,
                trailing: const ThemeSwitcher(),
              ),

              const Spacer(),

              /// LOGOUT BUTTON
              const LogoutButton(),

              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}

/// =========================
/// PROFILE CARD
/// =========================
class _ProfileCard extends StatelessWidget {
  final String? email;

  const _ProfileCard({required this.email});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(blurRadius: 10, color: Colors.black.withOpacity(0.05)),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primary.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.mail_outline,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          const SizedBox(width: 12),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  email ?? "-",
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                const Text(
                  "Tài khoản Pill App",
                  style: TextStyle(fontSize: 12, color: Colors.grey),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// =========================
/// SETTING ITEM ROW
/// =========================
class _SettingItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final Widget trailing;

  const _SettingItem({
    super.key,
    required this.icon,
    required this.label,
    required this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 8),
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.secondary.withOpacity(0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 20),
          ),

          const SizedBox(width: 12),

          Expanded(
            child: Text(
              label,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w500),
            ),
          ),

          trailing,
        ],
      ),
    );
  }
}
