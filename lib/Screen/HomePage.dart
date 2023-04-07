// ignore_for_file: camel_case_types, use_build_context_synchronously

import 'package:cabapp/Screen/LoginPage.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
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
  final db = FirebaseFirestore.instance;
  DateTime dateTime = DateTime(2023, 04, 06);
  bool isChecked = true;
  int index = 0;
  bool unChecked = false;
  String? documentId;
  DateTime date = DateTime.now();
  TimeOfDay time = TimeOfDay.now();
  final selectedIndexes = <int>[];

  final CollectionReference Todos =
      FirebaseFirestore.instance.collection('Todos');

  Future<void> addStudent() {
    return Todos.doc(documentId)
        .set({
          'todo_name': nameController.text,
          'todo_date': date,
          'todo_time': {time.minute, time.hour}
        })
        .then((value) => print("Student data Added"))
        .catchError((error) => print("Student couldn't be added."));
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
              child: SingleChildScrollView(
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
                                right: MediaQuery.of(context).size.width / 15),
                            child: TextFormField(
                              controller: nameController,
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
                          left: MediaQuery.of(context).size.width / 1.85,
                          top: MediaQuery.of(context).size.height / 100),
                      child: GestureDetector(
                        onTap: () async {
                          DateTime? newDate = await showDatePicker(
                              context: context,
                              initialDate: date,
                              firstDate: DateTime(1900),
                              lastDate: DateTime(2100));

                          TimeOfDay? newTime = await showTimePicker(
                              context: context, initialTime: time);

                          if (newDate == null) return;
                          if (newTime == null) return;
                          setState(() {
                            date = newDate;
                            time = newTime;
                          });
                        },
                        child: const Icon(Icons.timer_rounded,
                            color: Colors.white, size: 35),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width / 1.6),
                      child: GestureDetector(
                        onTap: () async {
                          await addStudent();
                        },
                        child: Container(
                          width: 80,
                          height: 50,
                          decoration: const BoxDecoration(
                            color: Colors.green,
                            borderRadius: BorderRadius.only(
                                topRight: Radius.circular(30),
                                bottomRight: Radius.circular(30)),
                          ),
                          child: const Center(
                            child: Icon(Icons.add),
                          ),
                        ),
                      ),
                    ),
                  ]),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height / 12),
                  child: Column(children: [
                    Padding(
                      padding: EdgeInsets.only(
                          left: MediaQuery.of(context).size.width / 2),
                      child: const Text(
                        'Reminder',
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    ),
                    Stack(
                      children: [
                        Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Container(
                                  height: 400,
                                  width: 350,
                                  color: const Color(0xFF2A2951),
                                  child: StreamBuilder(
                                    stream: FirebaseFirestore.instance
                                        .collection('Todos')
                                        .snapshots(),
                                    builder: (context, snapshot) {
                                      if (!snapshot.hasData) {
                                        return const Center(
                                          child: CircularProgressIndicator(),
                                        );
                                      } else {
                                        return ListView(
                                          children:
                                              snapshot.data!.docs.map((docs) {
                                            return Card(
                                              elevation: 0,
                                              color: const Color(0xFF2A2951),
                                              child: CheckboxListTile(
                                                  checkboxShape:
                                                      RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                  ),
                                                  side: const BorderSide(
                                                      width: 3,
                                                      color: Color(0xFFBB1EF1)),
                                                  checkColor:
                                                      Colors.black,
                                                  activeColor: Color(0xFFBB1EF1),
                                                  controlAffinity:
                                                      ListTileControlAffinity
                                                          .leading,
                                                  title: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Text(
                                                        docs.data()[
                                                            'todo_name'],
                                                        style: const TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 17),
                                                      ),
                                                      Text(
                                                        docs
                                                            .data()['todo_time']
                                                            .toString(),
                                                        style: const TextStyle(
                                                            color: Colors.white,
                                                            fontSize: 17),
                                                      ),
                                                    ],
                                                  ),
                                                  value: selectedIndexes
                                                      .contains(index),
                                                  onChanged: (bool? value) {
                                                    setState(() {
                                                      if (value!) {
                                                        selectedIndexes
                                                            .add(index);
                                                      } else {
                                                        selectedIndexes
                                                            .remove(index);
                                                      }
                                                    });
                                                  }),
                                            );
                                          }).toList(),
                                        );
                                      }
                                    },
                                  )),
                            ]),
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
                                    color: const Color(0xFF7F39A9), width: 3)),
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: MediaQuery.of(context).size.width / 30,
                                  right:
                                      MediaQuery.of(context).size.width / 30),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  const Text("items",
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold)),
                                  GestureDetector(
                                    onTap: selectedIndexes.isEmpty ? null : () async {
                                      final batch = FirebaseFirestore.instance.batch();
                                         for (int index in selectedIndexes.toList()) {
                                           DocumentSnapshot document = (await FirebaseFirestore.instance.collection('Todos').get()).docs[index];
                                           batch.delete(document.reference);
                                         }
                                         await batch.commit();
                                         setState(() {
                                           selectedIndexes.clear();
                                         });
                                    },
                                    child: const Text(
                                      "Clear Completed",
                                      style: TextStyle(
                                          fontSize: 15,
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold),
                                    ),
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ]),
                ),
              ]))),
        ),
      )),
    );
  }
}
