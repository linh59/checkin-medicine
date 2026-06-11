import 'dart:async';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../../../../core/services/auth_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

final authProvider =
StateNotifierProvider<AuthNotifier, AuthState>(
      (ref) => AuthNotifier(),
);

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
      user: user ?? this.user,
      session: session ?? this.session,
      loading: loading ?? this.loading,
    );
  }
}

class AuthNotifier extends StateNotifier<AuthState> {
  AuthNotifier() : super(const AuthState()) {
    _init();
  }

  final _auth = AuthService.instance;
  StreamSubscription? _sub;

  Future<void> _init() async {
    final session = _auth.currentSession;

    state = state.copyWith(
      user: session?.user,
      session: session,
      loading: false,
    );

    _sub = _auth.authStateChanges.listen((data) {
      state = state.copyWith(
        user: data.session?.user,
        session: data.session,
        loading: false,
      );
    });
  }

  Future<void> signUp(String email, String password, String displayName) async {
    state = state.copyWith(loading: true);

    try {
      final user = await _auth.signUp(
        email: email,
        password: password,
        displayName: displayName
      );

      if (user == null) {
        throw Exception("Sign up failed");
      }
    } finally {
      state = state.copyWith(loading: false);
    }
  }

  Future<void> signIn(String email, String password) async {
    state = state.copyWith(loading: true);

    try {
      final user = await _auth.signIn(
        email: email,
        password: password,
      );

      if (user == null) {
        throw Exception("Login failed");
      }
    } finally {
      state = state.copyWith(loading: false);
    }
  }

  Future<void> signOut() async {
    state = state.copyWith(loading: true);

    await _auth.signOut();

    state = const AuthState(
      user: null,
      session: null,
      loading: false,
    );
  }


  @override
  void dispose() {
    _sub?.cancel();
    super.dispose();
  }
}