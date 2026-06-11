import 'package:checkin_medicine/features/auth/presentation/providers/profile_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProfileSwitcher extends ConsumerWidget {
  const ProfileSwitcher({
    super.key,
    this.showAvatar = true,
    this.compact = false,
  });

  final bool showAvatar;
  final bool compact;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(profileProvider);

    final current = state.profile;

    if (state.loading) {
      return const SizedBox(
        width: 28,
        height: 28,
        child: CircularProgressIndicator(strokeWidth: 2),
      );
    }

    if (state.profiles.isEmpty) {
      return const SizedBox();
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: Theme.of(context).dividerColor.withOpacity(0.2),
        ),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: current?.id ?? state.profiles.first.id,

          isDense: true,
          icon: const Icon(Icons.keyboard_arrow_down_rounded),

          onChanged: (value) {
            if (value == null) return;
            ref.read(profileProvider.notifier).setActiveProfile(value);
          },

          items: state.profiles.map((profile) {
            return DropdownMenuItem(
              value: profile.id,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  if (showAvatar)
                    CircleAvatar(
                      radius: compact ? 10 : 14,
                      child: const Icon(Icons.person_outline),
                    ),
                  if (showAvatar) const SizedBox(width: 8),

                  Text(profile.fullName),
                ],
              ),
            );
          }).toList(),
        ),
      ),
    );
  }
}