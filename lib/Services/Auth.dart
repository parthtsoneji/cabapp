import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:cabapp/Screen/HomeScreen.dart';

import '../Screen/Registration.dart';


class AuthService{
  FirebaseAuth auth = FirebaseAuth.instance;
  final gooleSignIn = GoogleSignIn();
  GoogleSignInAccount? _user;

  GoogleSignInAccount get user => _user!;

  handleState() {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return HomeScreen();
        } else {
          return const RegisterScreen();
        }
      },
    );
  }

  Future gooleLogIn() async {
    final googleUser = await gooleSignIn.signIn();
    if (googleUser == null) return;
    _user = googleUser;
    final googleAuth = await googleUser.authentication;
    final credencial = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken
    );
    await FirebaseAuth.instance.signInWithCredential(credencial);
  }
  void signOutGoogle() async {
    await gooleSignIn.signOut();
  }
}
