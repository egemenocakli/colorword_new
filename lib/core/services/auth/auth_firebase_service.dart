import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthenticationFirebaseService {
//Google auth
  Future<bool> signInWithGoogle() async {
    try {
      // Trigger the authentication flow
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      // Obtain the auth details from the request
      final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

      // Create a new credential
      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      print("giriş yapan mail: ${googleUser!.email}");
      print("giriş yapan adı: ${googleUser.displayName}");

      // Once signed in, return the UserCredential
      await FirebaseAuth.instance.signInWithCredential(credential);
      if (credential.accessToken != null) {
        return true;
      } else {
        return false;
      }
      //credential.accessToken != null ? return true : return false;
      //return credential.accessToken.toString();
    } catch (e) {
      throw e.toString();
    }
  }

  Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
  }
}