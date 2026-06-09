import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  AuthService._();

  static final instance = AuthService._();

  SupabaseClient get client => Supabase.instance.client;

  Session? get currentSession => client.auth.currentSession;

  User? get currentUser => client.auth.currentUser;

  Stream<AuthState> get authStateChanges =>
      client.auth.onAuthStateChange;

  bool get isLoggedIn => currentUser != null;

  Future<User?> signIn({
    required String email,
    required String password,
  }) async {
    final res = await client.auth.signInWithPassword(
      email: email,
      password: password,
    );

    return res.user;
  }

  Future<User?> signUp({
    required String email,
    required String password,
  }) async {
    final res = await client.auth.signUp(
      email: email,
      password: password,
    );

    return res.user;
  }

  Future<void> signOut() async {
    await client.auth.signOut();
  }
}