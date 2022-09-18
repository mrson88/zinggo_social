import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthRepository {
  final _firebaseAuth = FirebaseAuth.instance;
  Future<void> signUp({required String email, required String password}) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> signIn({
    required String email,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
    } on FirebaseAuthException catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;
      final credential = GoogleAuthProvider.credential(
          accessToken: googleAuth?.accessToken, idToken: googleAuth?.idToken);
      await FirebaseAuth.instance.signInWithCredential(credential);
      print('token ${googleAuth?.accessToken}');
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> signInWithFacebook() async {
    try {
      final fb = FacebookLogin();

// Log in
      final res = await fb.logIn(permissions: [
        FacebookPermission.publicProfile,
        FacebookPermission.email,
      ]);

      final FacebookAccessToken? accessToken = res.accessToken;

      print('Access token: ${accessToken!.token}');
      print(fb.getUserEmail().toString());
      print('token ${'googleAuth?.accessToken'}');
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<void> signOut() async {
    try {
      await FacebookLogin().logOut();
      await _firebaseAuth.signOut();
      final googleSignIn = GoogleSignIn();
      await googleSignIn.signOut();
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
