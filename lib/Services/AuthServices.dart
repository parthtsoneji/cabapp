// ignore_for_file: non_constant_identifier_names

import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService{
  final FirebaseAuth auth = FirebaseAuth.instance;
  final googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _user;
  String? userEmail;


  GoogleSignInAccount get user => _user!;

  Future<User?> google_Login({required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    final GoogleSignIn googleSignIn = GoogleSignIn();

    final GoogleSignInAccount? googleSignInAccount =
    await googleSignIn.signIn();

    if (googleSignInAccount != null) {
      final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleSignInAuthentication.accessToken,
        idToken: googleSignInAuthentication.idToken,
      );

      try {
        final UserCredential userCredential =
        await auth.signInWithCredential(credential);

        user = userCredential.user;
      } on FirebaseAuthException catch (e) {
        if (e.code == 'account-exists-with-different-credential') {
          // handle the error here
        }
        else if (e.code == 'invalid-credential') {
          // handle the error here
        }
      } catch (e) {
        // handle the error here
      }
    }
    SharedPreferences localData = await SharedPreferences.getInstance();
    userEmail = user!.email;
    localData.setString('userEmail', userEmail!);
    return user;
  }
  Future signOut() async {
    FirebaseAuth.instance.signOut();
  }

}
