import 'package:e_commerce/data/models/user_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserRepository {
  final supabase = Supabase.instance.client;

  Future<UserModel?> loginUser() async {
    final webClientId = dotenv.env['WEB_CLIENT_ID']!;
    final GoogleSignIn googleSignIn = GoogleSignIn(
      serverClientId: webClientId,
    );
    final googleUser = await googleSignIn.signIn();
    final googleAuth = await googleUser!.authentication;
    final accessToken = googleAuth.accessToken;
    final idToken = googleAuth.idToken;

    if (accessToken == null) {
      throw 'Google Sign In failed.';
    }
    if (idToken == null) {
      throw 'Google Sign In failed.';
    }
    return await supabase.auth
        .signInWithIdToken(
      provider: OAuthProvider.google,
      idToken: idToken,
      accessToken: accessToken,
    )
        .then((value) {
      if (value.session != null) {
        return UserModel(id: value.session!.user.id, email: value.session!.user.email ?? "");
      }
      throw 'Failed to sign in.';
    });
  }

  Future<void> logoutUser() async {
    await GoogleSignIn().signOut();
    await supabase.auth.signOut();
  }

  Stream<UserModel?> userStateStream() {
    return supabase.auth.onAuthStateChange.map((event) {
      if (event.session != null) {
        return UserModel(
            id: event.session!.user.id, email: event.session!.user.email ?? "");
      }
      return null;
    });
  }
}
