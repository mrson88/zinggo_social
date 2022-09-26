import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:zinggo_social/modules/chat_screen/helper/helper_function.dart';
import 'package:zinggo_social/modules/chat_screen/services/auth_service.dart';


class AuthRepository {
  AuthService authService = AuthService();
  final _firebaseAuth = FirebaseAuth.instance;
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  Future<void> signUp({required String email, required String password}) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);

      // saving the shared preference state

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
      UserCredential userCredential =
          await FirebaseAuth.instance.signInWithCredential(credential);
      print('token ${googleAuth?.accessToken}');
      // ----------------------
      DocumentSnapshot userExist = await firestore
          .collection('users')
          .doc(userCredential.user!.uid)
          .get();

      if (userExist.exists) {
        print("User Already Exists in Database");
      } else {
        {
          await firestore
              .collection('users')
              .doc(userCredential.user!.uid)
              .set({
            'email': userCredential.user!.email,
            'fullname': userCredential.user!.displayName,
            'profilePic': userCredential.user!.photoURL,
            'uid': userCredential.user!.uid,
            // 'date': DateTime.now(),
            'groups': ''
          });
          await HelperFunctions.saveUserLoggedInStatus(true);
          await HelperFunctions.saveUserEmailSF(userCredential.user!.email!);
          await HelperFunctions.saveUserNameSF(
              userCredential.user!.displayName!);

        }

      }
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
