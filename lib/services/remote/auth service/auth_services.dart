import 'package:quanlychitieu/models/user_profile.dart';
import 'package:quanlychitieu/services/remote/auth%20service/google%20auth/google_auth_service.dart';
import 'package:supabase_flutter/supabase_flutter.dart';


class AuthService {
  final _client = Supabase.instance.client;
  final GoogleAuthService _googleAuthService = GoogleAuthService();

  /// GET CURRENT USER
  User? get currentUser => _client.auth.currentUser;

  /// GOOGLE LOGIN
  Future<User?> signInWithGoogle() async {
    final response = await _googleAuthService.signInWithGoogle();
    return response?.user;
  }

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

  /// GET USER PROFILE
  Future<UserProfile?> getUserProfile() async{
    final user = _client.auth.currentUser;
    if (user == null) return null;

    final data = await _client
        .from('user_profiles')
        .select()
        .eq('id', user.id)
        .single();

    return UserProfile.fromJson(data);
  }

  /// UPDATE USER PROFILE
  Future<void> updateUserProfile({
    String? fullName,
    String? avatarUrl,
    String? phoneNumber,
    DateTime? dateOfBirth,
    String? address,
  }) async {
    final user = _client.auth.currentUser;
    if (user == null) return;

    await _client.from('user_profiles').update({
      if (fullName != null) 'full_name': fullName,
      if (avatarUrl != null) 'avatar_url': avatarUrl,
      if (phoneNumber != null) 'phone_number': phoneNumber,
      if (dateOfBirth != null)
        'date_of_birth': dateOfBirth.toIso8601String(),
      if (address != null) 'address': address,
      'updated_at': DateTime.now().toIso8601String(),
    }).eq('id', user.id);

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
    print('User signed up: ${res.user!.id}');
  }

  /// CHECK LOGIN
  bool isLoggedIn() {
    return _client.auth.currentSession != null;
  }

  /// SEND RESET PASSWORD EMAIL (BY LINK)
  Future<void> sendResetPasswordEmail(String email) async {
    await _client.auth.resetPasswordForEmail(
      email,
      redirectTo: 'myapp://reset-password',
    );
  }

  /// UPDATE NEW PASSWORD
  Future<void> updatePassword(String newPassword) async {
    await _client.auth.updateUser(
      UserAttributes(
        password: newPassword,
      ),
    );
  }

  /// LOGOUT
  Future<bool> logout() async {
    await _googleAuthService.signOut();
    await _client.auth.signOut();
    return true;
  }
}
