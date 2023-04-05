import 'package:cabapp/Screen/HomePage.dart';
import 'package:cabapp/Screen/LoginPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  String? _email = '';

  Future<void> getEmailFromSharedPref() async {
    SharedPreferences pref = await SharedPreferences.getInstance();
    setState(() {
      _email = pref.getString('email');
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Scaffold(
          body: StreamBuilder(
            stream: FirebaseAuth.instance.authStateChanges(),
            builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const CircularProgressIndicator();
              } else {
                if (_email != null &&
                    snapshot.hasData &&
                    snapshot.data!.email == _email) {
                  return const HomePage();
                } else {
                  return const LoginPage();
                }
              }
            },
          ),
        ),
      ),
    );
  }
}
