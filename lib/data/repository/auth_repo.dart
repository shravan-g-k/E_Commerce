import 'package:e_commerce/data/models/user_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class UserRepository {
  final supabase = Supabase.instance.client;

  get userTable => 'users';

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
        .then((value) async {
      if (value.session != null) {
        PostgrestList data = await supabase
            .from(userTable)
            .select()
            .eq('id', value.session!.user.id);
        if (data.isEmpty) {
          await addUser(
            UserModel(
              id: value.session!.user.id,
              email: value.session!.user.email!,
              address: null,
              likes: [],
              cart: [],
            ),
          );
        }
        Map<String, dynamic> user = await supabase
            .from(userTable)
            .select()
            .eq('id', value.session!.user.id)
            .single();
        return UserModel.fromMap(user);
      }
      throw 'Failed to sign in.';
    });
  }

  Future<void> logoutUser() async {
    await GoogleSignIn().signOut();
    await supabase.auth.signOut();
  }

  Stream<UserModel?> userStateStream() {
    return supabase.auth.onAuthStateChange.asyncMap((event) async {
      try {
        if (event.session != null) {
          Map<String, dynamic> data = await supabase
              .from(userTable)
              .select()
              .eq('id', event.session!.user.id)
              .single();
          return UserModel.fromMap(data);
        }
      } catch (e) {
        return null;
      }
      return null;
    });
  }

  Future addUser(UserModel user) async {
    await supabase.from(userTable).insert(user.toMap());
  }

  Future updateUser(UserModel user) async {
    await supabase.from(userTable).update(user.toMap()).eq('id', user.id);
  }
}
