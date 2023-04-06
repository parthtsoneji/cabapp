// ignore_for_file: camel_case_types

import 'package:cabapp/Screen/LoginPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Services/AuthServices.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  DateTime dateTime = DateTime(2023, 04, 06);
  bool isChecked = false;

  Future<DateTime?> pickDate(BuildContext context) async {
    showDatePicker(
        context: context,
        initialDate: dateTime,
        firstDate: DateTime(1900),
        lastDate: DateTime(2100));
    if (dateTime != null) {
      setState(() {
        var data;
        data.text = dateTime.toLocal().toString().split(" ")[0];
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: SafeArea(
        child: Form(
            key: _formKey,
            child: Scaffold(
              backgroundColor: const Color(0xFF131136),
              appBar: AppBar(
                title: const Text(
                  "Alaram Todos",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.white,
                      fontWeight: FontWeight.bold),
                ),
                actions: [
                  Align(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                        onPressed: () {
                          AuthService()
                              .signOut()
                              .then((value) => Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => const LoginPage(),
                                  )));
                        },
                        child: const Text(
                          "LogOut",
                          style: TextStyle(
                              fontSize: 15,
                              color: Colors.black,
                              fontWeight: FontWeight.bold),
                        )),
                  )
                ],
              ),
              body: Padding(
                padding: EdgeInsets.only(
                    left: MediaQuery.of(context).size.width / 10,
                    top: MediaQuery.of(context).size.height / 10,
                    right: MediaQuery.of(context).size.width / 10),
                child: Column(children: [
                  Padding(
                    padding: EdgeInsets.only(
                        left: MediaQuery.of(context).size.width / 50,
                        right: MediaQuery.of(context).size.width / 50),
                    child: Stack(children: [
                      Container(
                          height: 50,
                          width: 500,
                          decoration: BoxDecoration(
                              color: const Color(0xFF2A2951),
                              borderRadius: BorderRadius.circular(25.0)),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: EdgeInsets.only(
                                  top: MediaQuery.of(context).size.height / 55,
                                  left: MediaQuery.of(context).size.width / 33,
                                  right:
                                      MediaQuery.of(context).size.width / 15),
                              child: TextFormField(
                                style: const TextStyle(
                                    fontSize: 17, color: Colors.white),
                                decoration: InputDecoration(
                                    border: OutlineInputBorder(
                                        borderSide: BorderSide.none,
                                        borderRadius:
                                            BorderRadius.circular(25.0)),
                                    hintStyle:
                                        const TextStyle(color: Colors.white),
                                    hintText: 'Create a new Todos...'),
                              ),
                            ),
                          )),
                      Padding(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width / 1.6),
                        child: GestureDetector(
                          onTap: () {},
                          child: Container(
                              height: 50,
                              width: 80,
                              decoration: const BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(40),
                                    bottomRight: Radius.circular(40)),
                                color: Colors.green,
                              ),
                              child:
                                  const Icon(Icons.add, color: Colors.white)),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                            left: MediaQuery.of(context).size.width / 1.85,
                            top: MediaQuery.of(context).size.height / 100),
                        child: GestureDetector(
                          onTap: () {
                            pickDate(context);
                          },
                          child: const Icon(Icons.timer_rounded,
                              color: Colors.white, size: 35),
                        ),
                      ),
                    ]),
                  ),
                  Padding(
                    padding: EdgeInsets.only(
                        top: MediaQuery.of(context).size.height / 12),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              left: MediaQuery.of(context).size.width / 2),
                          child: const Text(
                            'Reminder',
                            style: TextStyle(color: Colors.white, fontSize: 15),
                          ),
                        ),
                        Stack(children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                height: 400,
                                width: 350,
                                color: const Color(0xFF2A2951),
                                child: ListView.builder(
                                  itemCount: 1,
                                  itemBuilder: (context, index) {
                                    return GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          isChecked = true;
                                        });
                                      },
                                      child: Card(
                                          child: Padding(
                                            padding:  EdgeInsets.only(
                                              left: MediaQuery.of(context).size.width / 200,
                                              right: MediaQuery.of(context).size.width / 35
                                            ),
                                            child: Row(
                                        mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                        children: [
                                            //Checkbox
                                            Transform.scale(
                                                scale: 1.3,
                                                child: Checkbox(
                                                  shape: RoundedRectangleBorder(
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              10)),
                                                  checkColor: const Color(0xFF51197C),
                                                  value: isChecked,
                                                  fillColor: MaterialStateColor
                                                      .resolveWith((states) =>
                                                          const Color(0xFFBB1EF1)),
                                                  onChanged: (bool? value) {

                                                  },
                                                )),

                                            //User details
                                            const Text(
                                              "Coding",
                                              style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
                                            ),

                                            //User Time
                                            const Text(
                                              '11:25',
                                              style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),
                                            )
                                        ],
                                      ),
                                          )),
                                    );
                                  },
                                ),
                              ),
                            ],
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                top: MediaQuery.of(context).size.height / 2.2),
                            child: Container(
                              height: 40,
                              width: 350,
                              decoration: BoxDecoration(
                                  shape: BoxShape.rectangle,
                                  color: const Color(0xFF131136),
                                  boxShadow: const [
                                    BoxShadow(
                                        blurRadius: 15.0, color: Colors.white)
                                  ],
                                  border: Border.all(
                                      color: const Color(0xFF7F39A9),
                                      width: 3)),
                              child: Padding(
                                padding: EdgeInsets.only(
                                    left:
                                        MediaQuery.of(context).size.width / 30,
                                    right:
                                        MediaQuery.of(context).size.width / 30),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: const [
                                    Text("items",
                                        style: TextStyle(
                                            fontSize: 15,
                                            color: Colors.white,
                                            fontWeight: FontWeight.bold)),
                                    Text(
                                      "Clear Completed",
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    )
                                  ],
                                ),
                              ),
                            ),
                          )
                        ]),
                      ],
                    ),
                  )
                ]),
              ),
            )),
      ),
    );
  }
}
