import 'package:cabapp/Services/Auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: SafeArea(
        child: Scaffold(
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                FirebaseAuth.instance.currentUser!.email.toString(),
                style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
              Text(
                FirebaseAuth.instance.currentUser!.uid.toString(),
                style: const TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
              ),
              ElevatedButton(
                  onPressed: () {
                    AuthService().signOutGoogle();
                  },
                  child: const Text(
                    "Sign Out",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  )),
              ElevatedButton(
                  onPressed: () {
                   FirebaseAuth.instance.signOut();
                  },
                  child: const Text(
                    "user Out",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ))
            ],
          ),
        ),
      ),
    );
  }
}