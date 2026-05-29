import 'dart:async';

import 'package:checkin_medicine/features/auth/data/models/managed_profile.dart';
import 'package:checkin_medicine/features/auth/data/repositories/profile_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import '../../../auth/presentation/providers/auth_provider.dart';


final activeProfileProvider =
StateNotifierProvider<
    ActiveProfileNotifier,
    ActiveProfileState>(
      (ref) {
    return ActiveProfileNotifier(
      ref,
    );
  },
);

class ActiveProfileState {
  final bool loading;

  final ManagedProfileModel?
  profile;

  final List<
      ManagedProfileModel>
  profiles;

  const ActiveProfileState({
    this.loading = true,
    this.profile,
    this.profiles =
    const [],
  });

  ActiveProfileState copyWith({
    bool? loading,
    ManagedProfileModel?
    profile,
    List<
        ManagedProfileModel>?
    profiles,
  }) {
    return ActiveProfileState(
      loading:
      loading ??
          this.loading,

      profile:
      profile ??
          this.profile,

      profiles:
      profiles ??
          this.profiles,
    );
  }
}

class ActiveProfileNotifier
    extends StateNotifier<
        ActiveProfileState> {
  ActiveProfileNotifier(
      this.ref)
      : super(
    const ActiveProfileState(),
  ) {
    _init();
  }

  final Ref ref;

  final repository =
  ProfileRepository();

  Future<void> _init() async {
    try {
      final auth =
      ref.read(authProvider);

      final user =
          auth.user;

      if (user == null) {
        state = state.copyWith(
          loading: false,
        );
        return;
      }

      final profiles =
      await repository
          .getProfiles();

      final self =
          profiles
              .where(
                (p) =>
            p.linkedUserId ==
                user.id,
          )
              .firstOrNull;

      final active =
          self ??
              profiles
                  .firstOrNull;

      state = state.copyWith(
        loading: false,
        profiles: profiles,
        profile: active,
      );
    } catch (_) {
      state = state.copyWith(
        loading: false,
      );
    }
  }

  void setActiveProfile(
      String id) {
    final profile =
        state.profiles
            .where(
              (e) =>
          e.id == id,
        )
            .firstOrNull;

    state = state.copyWith(
      profile: profile,
    );
  }

  Future<void> refresh() async {
    await _init();
  }
}