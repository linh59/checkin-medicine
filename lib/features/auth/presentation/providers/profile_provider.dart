import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:collection/collection.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../data/models/managed_profile.dart';
import '../../data/repositories/profile_repository.dart';
import 'auth_provider.dart';

final profileProvider =
StateNotifierProvider<ProfileNotifier, ProfileState>(
      (ref) => ProfileNotifier(ref),
);

class ProfileState {
  final bool loading;
  final ManagedProfile? profile;
  final List<ManagedProfile> profiles;

  const ProfileState({
    this.loading = true,
    this.profile,
    this.profiles = const [],
  });

  ProfileState copyWith({
    bool? loading,
    ManagedProfile? profile,
    List<ManagedProfile>? profiles,
  }) {
    return ProfileState(
      loading: loading ?? this.loading,
      profile: profile ?? this.profile,
      profiles: profiles ?? this.profiles,
    );
  }
}

class ProfileNotifier extends StateNotifier<ProfileState> {
  ProfileNotifier(this.ref) : super(const ProfileState()) {
    _init();

    /// 🔥 IMPORTANT: auto reload when auth changes
    ref.listen(authProvider, (prev, next) {
      _init();
    });
  }

  final Ref ref;
  final repository = ProfileRepository();

  static const _key = 'active_profile_id';

  Future<void> _init() async {
    try {
      final auth = ref.read(authProvider);
      final user = auth.user;

      if (user == null) {
        state = state.copyWith(
          loading: false,
          profiles: [],
          profile: null,
        );
        return;
      }

      final profiles = await repository.getProfiles();

      final prefs = await SharedPreferences.getInstance();
      final savedId = prefs.getString(_key);

      ManagedProfile? active;

      /// 1. from saved selection
      if (savedId != null) {
        active = profiles.firstWhereOrNull(
              (p) => p.id == savedId,
        );
      }

      /// 2. fallback: linked to current user
      active ??= profiles.firstWhereOrNull(
            (p) => p.linkedUserId == user.id,
      );

      /// 3. fallback: first profile
      active ??= profiles.firstOrNull;

      state = state.copyWith(
        loading: false,
        profiles: profiles,
        profile: active,
      );
    } catch (e) {
      state = state.copyWith(loading: false);
    }
  }

  Future<void> setActiveProfile(String id) async {
    final profile = state.profiles.firstWhereOrNull(
          (e) => e.id == id,
    );

    if (profile == null) return;

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_key, id);

    state = state.copyWith(profile: profile);
  }

  Future<void> refresh() async {
    await _init();
  }
}