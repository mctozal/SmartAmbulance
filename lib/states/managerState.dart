import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ManagerState with ChangeNotifier {
  QuerySnapshot _locations;
  QuerySnapshot get locations => _locations;
  final databaseReference = Firestore.instance;

  ManagerState() {
    showUsers();
    showLocations();
  }

  Stream<QuerySnapshot> showUsers() {
    Stream<QuerySnapshot> stream =
        Firestore.instance.collection('users').getDocuments().asStream();
    return stream;
  }

  Stream<QuerySnapshot> showLocations() {
     Stream<QuerySnapshot> stream =
    Firestore.instance.collection("location").getDocuments().asStream();
    return stream;
  }
}
