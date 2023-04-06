import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import '../Class/Response.dart';

final FirebaseFirestore _firestore = FirebaseFirestore.instance;
final CollectionReference _collection = _firestore.collection('Todos');

class FirebaseCrud {
  Future<Response?> addUser({
    required String name,
    required String time,
    required String date
  }) async {
    Response response = Response();
    DocumentReference documentReference = _collection.doc();
    Map<String, dynamic> data = <String, dynamic>{
      'user_name': name,
      'user_time': time,
      'user_date': date
    };
    var result = await documentReference.set(data).whenComplete(() {
      response.code = 200;
      response.message = 'Succesfully added to the database';
    }).catchError((e){
      response.code = 500;
      response.message = e;
    });
    return response;
  }


  static Stream<QuerySnapshot> readUser() {
    CollectionReference noteItemCollection = _collection;
    return noteItemCollection.snapshots();
  }

  Future<Response?> upadteUser({
    required String name,
    required String time,
    required String date,
    required String docId
   }) async {
    Response response = Response();
    DocumentReference documentReference = _collection.doc(docId);
    Map<String, dynamic> data = <String, dynamic>{
      'user_name': name,
      'user_time': time,
      'user_date': date
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