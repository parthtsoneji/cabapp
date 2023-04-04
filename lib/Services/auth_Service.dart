// ignore_for_file: non_constant_identifier_names

import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cabapp/Screen/home_Screen.dart';
import '../Screen/register_Page.dart';

class AuthService {

  final FirebaseAuth auth = FirebaseAuth.instance;
  final googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _user;

  GoogleSignInAccount get user => _user!;

  var email = '';
  var password = '';
  var name = '';
  var confirmPassword = '';

  BuildContext? get context => null;

  Widget handleState() {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return const home_Page();
        } else {
          return const register_Page();
        }
      },
    );
  }

  Future google_Login() async {
    final googleUser = await googleSignIn.signIn();
    if (googleUser == null) return;
    _user = googleUser;
    final googleAuth = await googleUser.authentication;
    final credencial = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken, idToken: googleAuth.idToken);
    await FirebaseAuth.instance.signInWithCredential(credencial);
  }

  void signOutGoogle() async {
    await googleSignIn.signOut();
  }
}
