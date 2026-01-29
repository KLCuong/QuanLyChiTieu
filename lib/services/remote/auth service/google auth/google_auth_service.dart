import 'package:google_sign_in/google_sign_in.dart';
import 'package:quanlychitieu/configs/supabase_keys.dart';
import 'package:quanlychitieu/services/remote/supabase_services.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class GoogleAuthService {
  final GoogleSignIn _googleSignIn = GoogleSignIn(
    serverClientId: SupabaseKeys.supa_clientId,
    scopes: ['email', 'profile'],
  );

  final SupabaseClient _supabase = SupabaseServices.client;

  Future<AuthResponse?> signInWithGoogle() async {
    print('ClientId = ${_googleSignIn.clientId}');
    final googleUser = await _googleSignIn.signIn();
    if (googleUser == null) return null;

    final googleAuth = await googleUser.authentication;

    final idToken = googleAuth.idToken;
    final accessToken = googleAuth.accessToken;

    if (idToken == null || accessToken == null) {
      throw Exception('Google token is null');
    }

    return await _supabase.auth.signInWithIdToken(
      provider: OAuthProvider.google,
      idToken: idToken,
      accessToken: accessToken,
    );
  }

  Future<Map<String?, dynamic>?> getGoogleAcountProfile() async{
    final googleUser =
        _googleSignIn.currentUser ?? await _googleSignIn.signInSilently();

    if (googleUser == null) return null;

    final profile = {
      "fullName" : googleUser!.displayName,
      "email": googleUser!.email,
      "avatar_url": googleUser!.photoUrl,
    };
    return profile;
  }

  Future<void> signOut() async {
    await _googleSignIn.signOut();
    await _supabase.auth.signOut();
  }
}
