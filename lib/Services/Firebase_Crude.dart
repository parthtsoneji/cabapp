
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../Class/Response.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _collection = _firestore.collection('Todos');

class FirebaseCrud {
  static Future<Response> addUser({
    required String name,
    required DateTime date,
    required TimeOfDay time
  }) async {
    Response response = Response();
    DocumentReference documentReference = _collection.doc();
    Map<String, dynamic> data = <String, dynamic>{
      'user_name': name,
      'user_date': date,
      'user_time' : time
    };
    var result = await documentReference.set(data).whenComplete(() {
      response.code = 200;
      response.message = 'Succesfully added to the database';
    }).catchError((e){
      response.code = 500;
      response.message = 'Hello';
    });
    return response;
  }

  static Stream<QuerySnapshot> readUser() {
    CollectionReference noteItemCollection = _collection;
    return noteItemCollection.snapshots();
  }

  static Future<Response?> upadteUser({
    required String name,
    required DateTime date,
    required TimeOfDay time,
    required String docId
   }) async {
    Response response = Response();
    DocumentReference documentReference = _collection.doc(docId);
    Map<String, dynamic> data = <String, dynamic>{
      'user_name': name,
      'user_date': date,
      'user_time' : time
    };
    var result = await documentReference.update(data).whenComplete(() {
      response.code = 200;
      response.message = 'Succesfully Update user';
    }).catchError((e){
      response.code = 500;
      response.message = e;
    });
    return response;
  }

  static Future<Response> deleteUser({
    required String docId,
  }) async {
    Response response = Response();
    DocumentReference documentReferencer =
    _collection.doc(docId);

    await documentReferencer
        .delete()
        .whenComplete((){
      response.code = 200;
      response.message = "Sucessfully Deleted Employee";
    })
        .catchError((e) {
      response.code = 500;
      response.message = e;
    });

    return response;
  }
}