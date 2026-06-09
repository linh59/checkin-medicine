import 'package:checkin_medicine/features/auth/presentation/pages/login_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/theme/app_colors.dart';
import '../../../l10n/app_localizations.dart';
import '../../auth/presentation/providers/auth_provider.dart';

class LogoutButton extends ConsumerWidget {
  const LogoutButton({
    super.key,
  });

  Future<void> _logout(
      BuildContext context,
      WidgetRef ref,
      ) async {
    try {
      await ref
          .read(authProvider.notifier)
          .signOut();
      if (!context.mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Logout successful"),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {


      ScaffoldMessenger.of(context)
          .showSnackBar(
        SnackBar(
          content: Text(
            'Logout failed: $e',
          ),
        ),
      );
    }
  }

  @override
  Widget build(
      BuildContext context,
      WidgetRef ref,
      ) {
    final t = AppLocalizations.of(context)!;

    return SafeArea(
      top: false,
      child: Container(
        padding: const EdgeInsets.fromLTRB(
          16,
          12,
          16,
          12,
        ),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: Colors.black
                  .withOpacity(0.06),
              blurRadius: 18,
              offset:
              const Offset(0, -2),
            ),
          ],
        ),
        child: SizedBox(
          height: 52,
          width: double.infinity,
          child:
          ElevatedButton.icon(
            onPressed: () =>
                _logout(
                  context,
                  ref,
                ),
            icon: const Icon(
              Icons.logout,
            ),
            label: Text(
              t.logout,
              style:
              const TextStyle(
                fontWeight:
                FontWeight.w700,
              ),
            ),
            style:
            ElevatedButton
                .styleFrom(
              backgroundColor:
              WellnessColors
                  .error,
              foregroundColor:
              Colors.white,
              elevation: 0,
              shape:
              RoundedRectangleBorder(
                borderRadius:
                BorderRadius
                    .circular(
                  16,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}