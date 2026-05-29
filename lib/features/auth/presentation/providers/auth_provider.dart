import 'dart:async';

import 'package:flutter_riverpod/legacy.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../../../core/services/auth_service.dart';


final authProvider =
StateNotifierProvider<
    AuthNotifier,
    AuthState>(
      (ref) => AuthNotifier(),
);

class AuthState {
  final Session? session;
  final User? user;
  final bool loading;

  const AuthState({
    this.session,
    this.user,
    this.loading = true,
  });

  AuthState copyWith({
    Session? session,
    User? user,
    bool? loading,
  }) {
    return AuthState(
      session: session ??
          this.session,
      user: user ?? this.user,
      loading:
      loading ?? this.loading,
    );
  }
}

class AuthNotifier
    extends StateNotifier<AuthState> {
  AuthNotifier()
      : super(
    const AuthState(),
  ) {
    _init();
  }

  final _authService =
      AuthService.instance;

  StreamSubscription?
  _authSubscription;

  Future<void> _init() async {
    try {
      final session =
          _authService.currentSession;

      state = state.copyWith(
        session: session,
        user: session?.user,
        loading: false,
      );

      _authSubscription =
          _authService
              .authStateChanges
              .listen((data) {
            final session =
                data.session;

            state = state.copyWith(
              session: session,
              user: session?.user,
              loading: false,
            );
          });
    } catch (_) {
      state = state.copyWith(
        loading: false,
      );
    }
  }

  Future<void> signOut() async {
    await _authService.signOut();
  }

  @override
  void dispose() {
    _authSubscription?.cancel();
    super.dispose();
  }
}