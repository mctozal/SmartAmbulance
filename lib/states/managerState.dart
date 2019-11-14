import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ManagerState with ChangeNotifier {
  QuerySnapshot _locations;
  QuerySnapshot get locations => _locations;
  final databaseReference = Firestore.instance;

  ManagerState() {
    showUsersOnline();
  }

  StreamBuilder<QuerySnapshot> showUsersOnline() {
    int online = 0;
    Stream<QuerySnapshot> stream =
        Firestore.instance.collection('users').getDocuments().asStream();
    return StreamBuilder<QuerySnapshot>(
        stream: stream,
        builder: (context, snapshot) {
          List<DocumentSnapshot> list = snapshot.data.documents;
          Iterable<int>.generate(list.length).forEach((index) => {
                snapshot.data.documents[index].data["isOnline"].toString() ==
                        'true'
                    ? online++
                    : online
              });
          if (snapshot.hasError) {
            return CircularProgressIndicator();
          } else
            return Text('$online',
                style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w700,
                    fontSize: 34.0));
        });
  }
}
