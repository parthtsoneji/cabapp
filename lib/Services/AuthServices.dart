// ignore_for_file: non_constant_identifier_names

import 'package:cabapp/Screen/HomePage.dart';
import 'package:cabapp/Screen/LoginPage.dart';
import 'package:flutter/cupertino.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../Screen/RegisterPage.dart';


class AuthService {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final googleSignIn = GoogleSignIn();
  GoogleSignInAccount? _user;

 GoogleSignInAccount get user => _user!;

  handleState() {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return LoginPage();
        }
        if(snapshot.hasData == emailId){
          return HomePage();
        }
        else {
          return const RegisterPage();
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

  Future signOut() async {
    FirebaseAuth.instance.signOut();
  }
}
