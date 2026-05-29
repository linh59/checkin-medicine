import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  AuthService._();

  static final instance =
  AuthService._();

  SupabaseClient get client =>
      Supabase.instance.client;

  Session? get currentSession =>
      client.auth.currentSession;

  User? get currentUser =>
      client.auth.currentUser;

  Stream<AuthState>
  get authStateChanges =>
      client.auth.onAuthStateChange;

  Future<AuthResponse> signIn({
    required String email,
    required String password,
  }) async {
    return await client.auth
        .signInWithPassword(
      email: email,
      password: password,
    );
  }

  Future<AuthResponse> signUp({
    required String email,
    required String password,
  }) async {
    return await client.auth.signUp(
      email: email,
      password: password,
    );
  }

  Future<void> signOut() async {
    await client.auth.signOut();
  }
}