import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smart_ambulance/model/patientInfo.dart';
import 'package:smart_ambulance/model/users.dart';
import 'package:smart_ambulance/states/crudState.dart';

class ManagerState with ChangeNotifier {
  CRUDState crudState = new CRUDState();
  QuerySnapshot _locations;
  QuerySnapshot get locations => _locations;
  final databaseReference = Firestore.instance;
  int _isOnline = 0;
  int get isOnline => _isOnline;

  ManagerState() {
    getUsersOnline();
  }

  getUsersOnline() async {
    _isOnline = 0;
    List<User> users = await crudState.fetchUsers();
    for (int i = 0; i < users.length; i++) {
      if (users[i].isOnline) {
        _isOnline++;
      }
    }
  }

  Future<List<User>> fetchAllUsers() async {
    List<User> users = await crudState.fetchUsers();
    return users;
  }

  Future<List<Patient>> fetchAllEmergency() async {
    List<Patient> patient = await crudState.fetchEmergency();
    return patient;
  }
}
