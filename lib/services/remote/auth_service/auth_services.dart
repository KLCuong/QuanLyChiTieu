import 'package:supabase_flutter/supabase_flutter.dart';

class AuthService {
  final _client = Supabase.instance.client;

  /// LOGIN
  Future<void> login({
    required String email,
    required String password,
  }) async {
    await _client.auth.signInWithPassword(
      email: email,
      password: password,
    );
  }

  /// SIGN UP
  Future<void> signUp({
    required String email,
    required String password,
    required String fullName,
  }) async {
    final res = await _client.auth.signUp(
      email: email,
      password: password,
      data: {
        'full_name': fullName,
      },
    );

    if (res.user == null) {
      throw Exception("Signup failed");
    }
  }

  /// CHECK LOGIN
  bool isLoggedIn() {
    return _client.auth.currentSession != null;
  }

  /// LOGOUT
  Future<void> logout() async {
    await _client.auth.signOut();
  }
}
