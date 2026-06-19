import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../../../../core/services/auth_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
class AuthState {
  final User? user;
  final Session? session;
  final bool loading;

  const AuthState({
    this.user,
    this.session,
    this.loading = true,
  });

  AuthState copyWith({
    User? user,
    Session? session,
    bool? loading,
  }) {
    return AuthState(
      user: user,
      session: session,
      loading: loading ?? this.loading,
    );
  }
}

final authProvider =
StateNotifierProvider<AuthNotifier, AuthState>(
      (ref) => AuthNotifier(),
);

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier() : super(const AuthState()) {
    _init();
  }

  final _auth = AuthService.instance;
  StreamSubscription? _sub;

  // INIT
  Future<void> _init() async {
    final session = _auth.currentSession;

    state = AuthState(
      user: session?.user,
      session: session,
      loading: false,
    );

    _sub = _auth.authStateChanges.listen((data) {
      final session = data.session;

      if (session == null) {
        state = const AuthState(
          user: null,
          session: null,
          loading: false,
        );
        return;
      }

      state = AuthState(
        user: session.user,
        session: session,
        loading: false,
      );
    });
  }

  // SIGN IN
  Future<void> signIn(String email, String password) async {
    state = state.copyWith(loading: true);

    try {
      await _auth.signIn(
        email: email,
        password: password,
      );


    } finally {
      state = state.copyWith(loading: false);
    }
  }

  // SIGN UP
  Future<void> signUp(
      String email,
      String password,
      String displayName,
      ) async {
    state = state.copyWith(loading: true);

    try {
      await _auth.signUp(
        email: email,
        password: password,
        displayName: displayName,
      );
    } finally {
      state = state.copyWith(loading: false);
    }
  }

  // SIGN OUT
  Future<void> signOut() async {
    state = state.copyWith(loading: true);

    await _auth.signOut();

    state = const AuthState(
      user: null,
      session: null,
      loading: false,
    );
  }

  // DELETE ACCOUNT
  Future<void> deleteAccount() async {
    state = state.copyWith(loading: true);

    try {
      await _auth.deleteAccount();

      await Supabase.instance.client.auth.signOut(
        scope: SignOutScope.global,
      );

      state = const AuthState(
        user: null,
        session: null,
        loading: false,
      );
    } finally {
      state = state.copyWith(loading: false);
    }
  }

  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }
}