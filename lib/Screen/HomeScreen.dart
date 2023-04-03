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
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            FirebaseAuth.instance.currentUser!.email!,
            style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          ElevatedButton(
              onPressed: () {
                AuthService().signOut();
              },
              child: const Text(
                "Sign Out",
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ))
        ],
      ),
    );
  }
}