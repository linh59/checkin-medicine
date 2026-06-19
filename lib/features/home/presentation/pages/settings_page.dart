import 'package:checkin_medicine/features/auth/presentation/pages/login_page.dart';
import 'package:checkin_medicine/features/auth/presentation/providers/auth_provider.dart';
import 'package:checkin_medicine/features/home/widgets/logout_button.dart';
import 'package:checkin_medicine/features/home/widgets/setting/setting_action_item.dart';
import 'package:checkin_medicine/l10n/app_localizations.dart';
import 'package:checkin_medicine/shared/widgets/language_switcher.dart';
import 'package:checkin_medicine/shared/widgets/theme_switcher.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SettingsPage extends ConsumerStatefulWidget {
  const SettingsPage({super.key});

  @override
  ConsumerState<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends ConsumerState<SettingsPage> {
  bool _isDeleting = false;

  Future<void> _deleteAccount() async {
    final t = AppLocalizations.of(context)!;

    try {
      setState(() {
        _isDeleting = true;
      });

      await ref.read(authProvider.notifier).deleteAccount();

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            t.accountDeletedSuccessfully,
          ),
        ),
      );
      // Navigator.of(context).pushAndRemoveUntil(
      //   MaterialPageRoute(
      //     builder: (_) => const LoginPage(),
      //   ),
      //       (route) => false,
      // );


    } catch (e) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            '${t.error}: $e',
          ),
        ),
      );
    } finally {
      if (mounted) {
        setState(() {
          _isDeleting = false;
        });
      }
    }
  }

  Future<void> _showDeleteAccountDialog() async {
    final t = AppLocalizations.of(context)!;

    final confirmed = await showDialog<bool>(
      context: context,
      builder: (_) {
        return AlertDialog(
          title: Text(t.deleteAccount),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                t.deleteAccountConfirm,
              ),
              const SizedBox(height: 8),
              Text(
                t.deleteAccountWarning,
                style: const TextStyle(
                  color: Colors.red,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context, false);
              },
              child: Text(t.cancel),
            ),
            FilledButton(
              style: FilledButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              onPressed: () {
                Navigator.pop(context, true);
              },
              child: Text(t.delete),
            ),
          ],
        );
      },
    );

    if (confirmed != true) return;

    await _deleteAccount();
  }

  @override
  Widget build(BuildContext context) {
    final t = AppLocalizations.of(context)!;
    final size = MediaQuery.of(context).size;

    final horizontalPadding = size.width < 600 ? 16.0 : 24.0;

    final auth = ref.watch(authProvider);
    final user = auth.user;

    return Scaffold(
      appBar: AppBar(
        title: Text(t.settings),
      ),
      body: Stack(
        children: [
          SafeArea(
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: horizontalPadding,
              ),
              child: Column(
                children: [
                  const SizedBox(height: 12),

                  if (user != null)
                    _ProfileCard(
                      user: user,
                    ),

                  const SizedBox(height: 16),

                  _SettingItem(
                    icon: Icons.dark_mode_outlined,
                    label: t.darkMode,
                    trailing: const ThemeSwitcher(),
                  ),

                  const SizedBox(height: 16),

                  SettingActionItem(
                    icon: Icons.delete_forever_outlined,
                    label: t.deleteAccount,
                    iconColor: Colors.red,
                    textColor: Colors.red,
                    onTap: _showDeleteAccountDialog,
                  ),

                  const SizedBox(height: 16),

                  const LogoutButton(),

                  const Spacer(),

                   LanguageSwitcher(),

                  const SizedBox(height: 16),
                ],
              ),
            ),
          ),

          if (_isDeleting)
            Container(
              color: Colors.black26,
              child: const Center(
                child: CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }
}

/// =========================
/// PROFILE CARD
/// =========================

class _ProfileCard extends StatelessWidget {
  final User user;

  const _ProfileCard({
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    final name = user.userMetadata?['display_name'];
    final email = user.email;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            blurRadius: 10,
            color: Colors.black.withOpacity(0.05),
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            width: 52,
            height: 52,
            decoration: BoxDecoration(
              color: Theme.of(context)
                  .colorScheme
                  .primary
                  .withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(
              Icons.person_outline,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment:
              CrossAxisAlignment.start,
              children: [
                Text(
                  name ?? '',
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  email ?? '',
                  style: const TextStyle(
                    fontSize: 12,
                    color: Colors.grey,
                  ),
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
/// SETTING ITEM
/// =========================

class _SettingItem extends StatelessWidget {
  final IconData icon;
  final String label;
  final Widget trailing;

  const _SettingItem({
    required this.icon,
    required this.label,
    required this.trailing,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 8,
      ),
      padding: const EdgeInsets.symmetric(
        horizontal: 16,
        vertical: 12,
      ),
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
              color: Theme.of(context)
                  .colorScheme
                  .secondary
                  .withOpacity(0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(
              icon,
              size: 20,
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text(
              label,
              style: const TextStyle(
                fontSize: 15,
                fontWeight: FontWeight.w500,
              ),
            ),
          ),
          trailing,
        ],
      ),
    );
  }
}