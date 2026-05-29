import 'package:checkin_medicine/features/auth/presentation/providers/profile_provider.dart';
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
    final profileState = ref.watch(profileProvider);

    final currentProfile = profileState.profile;

    if (profileState.loading) {
      return const SizedBox(
        width: 28,
        height: 28,
        child: CircularProgressIndicator(strokeWidth: 2),
      );
    }

    if (profileState.profiles.isEmpty) {
      return const SizedBox();
    }

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),

      decoration: BoxDecoration(
        color: Theme.of(context).colorScheme.surface,

        borderRadius: BorderRadius.circular(16),

        border: Border.all(
          color: Theme.of(context).dividerColor.withValues(alpha: 0.2),
        ),
      ),

      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: currentProfile?.id,

          isDense: true,

          borderRadius: BorderRadius.circular(16),

          icon: const Icon(Icons.keyboard_arrow_down_rounded),

          onChanged: (value) {
            if (value == null) {
              return;
            }

            ref.read(profileProvider.notifier).setActiveProfile(value);
          },

          items: profileState.profiles
              .map(
                (profile) => DropdownMenuItem<String>(
                  value: profile.id,

                  child: Row(
                    mainAxisSize: MainAxisSize.min,

                    children: [
                      if (showAvatar)
                        CircleAvatar(
                          radius: compact ? 10 : 14,

                          backgroundColor: Theme.of(
                            context,
                          ).colorScheme.primaryContainer,

                          child: Icon(
                            Icons.person_outline,
                            size: compact ? 12 : 16,
                          ),
                        ),

                      if (showAvatar) const SizedBox(width: 8),

                      Text(
                        profile.fullName,

                        style: TextStyle(fontSize: compact ? 13 : 14),
                      ),
                    ],
                  ),
                ),
              )
              .toList(),
        ),
      ),
    );
  }
}
