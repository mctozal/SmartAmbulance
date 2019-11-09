import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ManagerState with ChangeNotifier {
  var _uid = <String>[];
  get uid => _uid;
  final databaseReference = Firestore.instance;

  ManagerState() {}

  Future<List<dynamic>> showUser() async {
    getData();
    return _uid;
  }

  getData() async {
    var list;
    await databaseReference
        .collection("users")
        .getDocuments()
        .then((QuerySnapshot snapshot) {
      snapshot.documents.forEach((f) => list = f.data);
      _uid.add(list["user-mail"]);
    });

    notifyListeners();
  }
}
