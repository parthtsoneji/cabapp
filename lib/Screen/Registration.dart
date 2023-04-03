import 'package:cabapp/Screen/LoginPage.dart';
import 'package:flutter/material.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final nameController = TextEditingController();
  final emaiController = TextEditingController();
  final passController = TextEditingController();
  final confpassController = TextEditingController();
  final _registerfeild = GlobalKey<FormState>();
  bool pass = true;
  bool confpass = true;
  bool temp = false;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
            body: SingleChildScrollView(
              child: Form(
                //form Change event for form field or not
                onChanged: () {
                  if (_registerfeild.currentState?.validate() == true) {
                    setState(() {
                      temp = true;
                    });}
                  else {
                    setState(() {
                      temp = false;
                    });
                  }},
                key: _registerfeild,

                child: Column(children: [

                  //Image
                  Image(
                    image: const AssetImage('images/car.png'),
                    fit: BoxFit.cover,
                    height: MediaQuery.of(context).size.height / 7.5,
                    width: MediaQuery.of(context).size.width,
                  ),

                  Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width / 15,
                        top: MediaQuery.of(context).size.height / 25),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [

                        //Text
                        const Text(
                          "Sign Up to Masterminds",
                          style: TextStyle(fontSize: 17,
                              fontWeight: FontWeight.w500,
                              color: Colors.black),),

                        const SizedBox(height: 7),

                        // Text for already have account
                        Row(
                            children: [
                              const Text("Already have an account?",
                                  style: TextStyle(
                                      fontSize: 13,
                                      fontWeight: FontWeight.w600,
                                      color: Colors.grey)),
                              const SizedBox(width: 5),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: const Text(
                                  "Login",
                                  style: TextStyle(
                                      color: Colors.indigoAccent,
                                      fontWeight: FontWeight.w500,
                                      fontSize: 11),),)
                            ]),

                        Padding(
                          padding: EdgeInsets.only(
                              top: MediaQuery.of(context).size.height / 22,
                              right: MediaQuery.of(context).size.width / 15),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [

                              //color for TextField
                              Theme(
                                  data: ThemeData(
                                      highlightColor: Colors.grey,
                                      inputDecorationTheme: const InputDecorationTheme(
                                          fillColor: Colors.grey)),

                                  //Name TextField
                                  child: TextFormField(
                                      controller: nameController,
                                      autovalidateMode: AutovalidateMode.onUserInteraction,
                                      decoration: InputDecoration(
                                          filled: true,
                                          fillColor: Colors.grey.shade200,
                                          contentPadding: EdgeInsets.only(
                                              left: MediaQuery.of(context).size.width / 20),
                                          border: OutlineInputBorder(
                                              borderSide: BorderSide.none,
                                              borderRadius: BorderRadius.circular(10.0)),
                                          hintText: " Full Name"),
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "Please Enter Full Name";
                                        }
                                        return null;
                                      }
                                  )
                              ),

                              SizedBox(height: MediaQuery.of(context).size.height / 45),

                              //Email TextField
                              TextFormField(
                                  autovalidateMode: AutovalidateMode.onUserInteraction,
                                  controller: emaiController,
                                  decoration: InputDecoration(
                                      filled: true,
                                      fillColor: Colors.grey.shade200,
                                      contentPadding: EdgeInsets.only(
                                          left: MediaQuery.of(context).size.width / 20),
                                      border: OutlineInputBorder(
                                          borderSide: BorderSide.none,
                                          borderRadius: BorderRadius.circular(10.0)),
                                      hintText: "Email"),

                                  //Validation for empty or not
                                  validator: (value) {
                                    final bool emailValid = RegExp(
                                        r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                                        .hasMatch(value!);
                                    if (value.isEmpty) {
                                      return "Enter Email";
                                    }
                                    else if (!emailValid) {
                                      return "Enter Valid Email";
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
                                      )),
                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Enter Password";
                                    }
                                    else if (passController.text.length < 6) {
                                      return "Password Length Should be more than 6 charcters";
                                    }}),

                              SizedBox(height: MediaQuery.of(context).size.height / 45),

                              //Confirm Password
                              TextFormField(
                                  controller: confpassController,
                                  obscureText: true ,
                                  autovalidateMode: AutovalidateMode.onUserInteraction,
                                  decoration: InputDecoration(
                                    filled: true,
                                    fillColor: Colors.grey.shade200,
                                    contentPadding: EdgeInsets.only(
                                        left: MediaQuery.of(context).size.width / 20),
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius: BorderRadius.circular(10.0)),
                                    hintText: "Confirm Password",),

                                  validator: (value) {
                                    if (value!.isEmpty) {
                                      return "Confirm Password";
                                    }
                                    else if (confpassController.text.length < 6) {
                                      return "Confirm Password Length Should be more than 6 charcters";
                                    }
                                    else if (passController.text !=
                                        confpassController.text) {
                                      return "Not Match";
                                    }
                                    return null;
                                  }),

                              SizedBox(height: MediaQuery.of(context).size.height / 45),

                              //Elevated Button for Creating Account
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.indigoAccent,
                                      elevation: 0.1,
                                      minimumSize: Size(
                                          MediaQuery.of(context).size.height / 1,
                                          MediaQuery.of(context).size.width / 9),
                                      shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(5.0))),
                                  onPressed: temp == true
                                      ? () {
                                    Navigator.push(context, MaterialPageRoute(builder: (context) => LoginPage(),));
                                  } : null,
                                  child: const Text("Creating Account",style: TextStyle(color: Colors.white))
                              ),

                              SizedBox(height: MediaQuery.of(context).size.height / 30),

                              //Text
                              Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Expanded(
                                      child: Container(height: 0.1,color: Colors.grey,)),

                                  const SizedBox(width: 15),

                                  const Text("or sign up via",style: TextStyle(fontSize: 10, color: Colors.grey),),

                                  const SizedBox(width: 15),

                                  Expanded(
                                      child: Container(height: 0.1,color: Colors.grey,)),
                                ],
                              ),

                              SizedBox(height: MediaQuery.of(context).size.height / 30),

                              //Elevated Button For Google
                              ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.white,
                                    elevation: 0.1,
                                    minimumSize: Size(
                                        MediaQuery.of(context).size.height / 1,
                                        MediaQuery.of(context).size.width / 9),
                                    shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5.0)),
                                    side: const BorderSide(color: Colors.black12),
                                  ),
                                  onPressed: () {},
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: const [
                                      Image(
                                        image: AssetImage("images/123.png"),
                                        height: 40,
                                        width: 20,
                                      ),

                                      SizedBox(width: 5),

                                      Text("Google",style:
                                      TextStyle(color: Colors.black,fontWeight: FontWeight.bold)),
                                    ],
                                  )
                              ),

                              SizedBox(height: MediaQuery.of(context).size.height / 30),

                              //Text
                              Text("By signing up to Masterminds you agree to our",
                                  style: TextStyle(fontSize: 11, color: Colors.grey.shade600)),

                              SizedBox(
                                  height: MediaQuery.of(context).size.height / 300),

                              // Terms & Conditions
                              const Text("terms and conditions", style:
                              TextStyle(color: Colors.indigoAccent, fontSize: 11))
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ]),
              ),
            )
        )
    );
  }
}