import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ManagerState with ChangeNotifier {
  QuerySnapshot _users;
  QuerySnapshot _locations;
  QuerySnapshot get users => _users;
  QuerySnapshot get locations => _locations;
  final databaseReference = Firestore.instance;

  ManagerState() {
    showUsers();
    showLocations();
  }

  showUsers() async {
    await databaseReference.collection("users").getDocuments().then((result) {
      _users = result;
    });
    notifyListeners();
  }

  showLocations() async {
    await databaseReference
        .collection("location")
        .getDocuments()
        .then((result) {
      _locations = result;
    });
    notifyListeners();
  }
}
