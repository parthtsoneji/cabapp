import 'dart:async';

import 'package:cabapp/Screen/HomeScreen.dart';
import 'package:cabapp/Screen/Registration.dart';
import 'package:cabapp/Services/Auth.dart';
import 'package:cabapp/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var email = '';
  var password = '';
  GlobalKey<FormState> _loginfeild = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passController = TextEditingController();
  bool pass = true;
  bool temp = false;

  @override
  void dispose() {
    emailController.dispose();
    passController.dispose();
    super.dispose();
  }
  userLogin() async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          backgroundColor: Colors.redAccent,
          content: Text(
            "User Login",
            style: TextStyle(
                fontSize: 18,color: Colors.red
            ),
          )));
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => MyApp(),
        ),
      );
    } on FirebaseAuthException catch (e) {
      if(e.code == 'user-not-found'){
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.redAccent,
            content: Text(
              "user-not-found",
              style: TextStyle(
                fontSize: 18,color: Colors.red
              ),
            )));
      }
      else if(e.code == 'Wrong Password'){
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            backgroundColor: Colors.redAccent,
            content: Text(
              "user-not-found",
              style: TextStyle(
                fontSize: 16,color: Colors.blue
              ),
            )));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      body: SingleChildScrollView(
        child: Form(
          //form Change event for form field or not
          onChanged: () {
            if (_loginfeild.currentState!.validate() == true) {
              setState(() {
                temp = true;
              });
            } else {
              setState(() {
                temp = false;
              });
            }
          },
          key: _loginfeild,
          child: Padding(
            padding: EdgeInsets.only(
                left: MediaQuery.of(context).size.width / 15,
                top: MediaQuery.of(context).size.height / 10),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  "Welcome, Sign In",
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: Colors.black),
                ),
                const SizedBox(height: 9),
                Padding(
                  padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.width / 120),
                  child: Row(
                    children: [
                      const Text("No Account?",
                          style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.w400)),
                      const SizedBox(width: 5),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RegisterScreen(),
                              ));
                        },
                        child: const Text(
                          "No Account?",
                          style: TextStyle(
                              color: Colors.indigoAccent,
                              fontWeight: FontWeight.w500,
                              fontSize: 11),
                        ),
                      )
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height / 22,
                      right: MediaQuery.of(context).size.width / 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      TextFormField(
                          controller: emailController,
                          decoration: InputDecoration(
                              filled: true,
                              fillColor: Colors.grey.shade200,
                              contentPadding: EdgeInsets.only(
                                  left: MediaQuery.of(context).size.width / 20),
                              border: OutlineInputBorder(
                                  borderSide: BorderSide.none,
                                  borderRadius: BorderRadius.circular(10.0)),
                              hintText: "Email"),
                          autovalidateMode: AutovalidateMode.onUserInteraction,

                          //Email Validator
                          validator: (value) {
                            final bool emailValid = RegExp(
                                    r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                .hasMatch(value!);
                            if (value!.isEmpty) {
                              return "Enter Email";
                            } else if (!emailValid) {
                              return "Enter Valid Email";
                            } else {
                              return null;
                            }
                          }),

                      SizedBox(height: MediaQuery.of(context).size.height / 45),

                      //Password TextField
                      TextFormField(
                        controller: passController,
                        obscureText: pass,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        decoration: InputDecoration(
                          filled: true,
                          fillColor: Colors.grey.shade200,
                          contentPadding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width / 20),
                          border: OutlineInputBorder(
                              borderSide: BorderSide.none,
                              borderRadius: BorderRadius.circular(10.0)),
                          hintText: "Password",
                          suffix: Padding(
                            padding: const EdgeInsets.only(right: 10),
                            child: GestureDetector(
                              onTap: () {
                                setState(() {
                                  pass = !pass;
                                });
                              },
                              child: Icon(pass
                                  ? Icons.visibility
                                  : Icons.visibility_off),
                            ),
                          ),
                        ),

                        //Password Validator
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "Enter Password";
                          } else if (passController.text.length < 6) {
                            return "Password Length Should be more than 6 charcters";
                          } else {
                            return null;
                          }
                        },
                      ),

                      SizedBox(height: MediaQuery.of(context).size.height / 16),

                      //Elevated Button For Sign In
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            onSurface: Colors.indigoAccent,
                            elevation: 0.1,
                            minimumSize: Size(
                                MediaQuery.of(context).size.height / 1,
                                MediaQuery.of(context).size.width / 9),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0)),
                          ),
                          onPressed: temp == true
                              ? () {
                                  if (_loginfeild.currentState!.validate()) {
                                    setState(() {
                                      email = emailController.text;
                                      password = passController.text;
                                    });
                                    userLogin();
                                  }
                                }
                              : null,
                          child: const Text("Log In ",
                              style: TextStyle(color: Colors.white))),

                      SizedBox(height: MediaQuery.of(context).size.height / 30),

                      //Text
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Expanded(
                              child: Container(
                            height: 0.1,
                            color: Colors.grey,
                          )),
                          const SizedBox(width: 15),
                          const Text(
                            "or sign up via",
                            style: TextStyle(fontSize: 10, color: Colors.grey),
                          ),
                          const SizedBox(width: 15),
                          Expanded(
                              child: Container(
                            height: 0.1,
                            color: Colors.grey,
                          )),
                        ],
                      ),

                      SizedBox(height: MediaQuery.of(context).size.height / 30),

                      //Elevated Button for Google
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.white,
                            elevation: 0.1,
                            minimumSize: Size(
                                MediaQuery.of(context).size.height / 1,
                                MediaQuery.of(context).size.width / 9),
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0)),
                          ),
                          onPressed: () {
                            AuthService().gooleLogIn();
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: const [
                              Image(
                                image: AssetImage("images/123.png"),
                                height: 40,
                                width: 20,
                              ),
                              SizedBox(width: 5),
                              Text(
                                "Google",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
                          )),

                      SizedBox(height: MediaQuery.of(context).size.height / 30),
                      Text("By signing up to Masterminds you agree to our",
                          style: TextStyle(
                              fontSize: 11, color: Colors.grey.shade600)),

                      SizedBox(
                          height: MediaQuery.of(context).size.height / 300),
                      //Terms & Conditions
                      const Text(
                        "terms and conditions",
                        style:
                            TextStyle(color: Colors.indigoAccent, fontSize: 11),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    ));
  }
}
