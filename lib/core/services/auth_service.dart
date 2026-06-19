import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  AuthService._();
  static final instance = AuthService._();

  SupabaseClient get client => Supabase.instance.client;

  Session? get currentSession => client.auth.currentSession;
  User? get currentUser => client.auth.currentUser;

  Stream<AuthState> get authStateChanges =>
      client.auth.onAuthStateChange;

  Future<AuthResponse> signIn({
    required String email,
    required String password,
  }) {
    return client.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  Future<AuthResponse> signUp({
    required String email,
    required String password,
    required String displayName,
  }) {
    return client.auth.signUp(
      email: email,
      password: password,
      data: {'display_name': displayName},
    );
  }

  Future<void> signOut() async {
    await client.auth.signOut();
  }

  Future<void> deleteAccount() async {
    final response = await client.functions.invoke(
      'delete-account',
    );

    if (response.status != 200) {
      throw Exception(
        response.data?['error'] ?? 'Failed to delete account',
      );
    }
  }
}