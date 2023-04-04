// ignore_for_file: camel_case_types

import 'package:cabapp/Services/auth_Service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class home_Page extends StatefulWidget {
  const home_Page({Key? key}) : super(key: key);

  @override
  State<home_Page> createState() => _home_PageState();
}

class _home_PageState extends State<home_Page> {
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
                style:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 5),

              Text(
                FirebaseAuth.instance.currentUser!.uid.toString(),
                style:
                    const TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),

              const SizedBox(height: 10),

              ElevatedButton(
                  onPressed: () {
                    AuthService().signOutGoogle();
                    FirebaseAuth.instance.signOut();
                  },
                  child: const Text(
                    "LogOut",
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  )),
            ],
          ),
        ),
      ),
    );
  }
}
