import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smart_ambulance/states/managerState.dart';

class AmbulanceOnlineList extends StatelessWidget {
  const AmbulanceOnlineList({
    Key key,
    @required this.managerState,
  }) : super(key: key);

  final ManagerState managerState;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Material(
        elevation: 14.0,
        borderRadius: BorderRadius.circular(12.0),
        shadowColor: Color(0x802196F3),
        child: StreamBuilder<QuerySnapshot>(
            stream: managerState.showUsersOnline(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              } else
                return ListView.builder(
                    itemCount: snapshot.data.documents.length,
                    itemBuilder: (context, index) => snapshot
                                .data.documents[index].data['isOnline']
                                .toString() ==
                            'true'
                        ? ListTile(
                            title: Text(snapshot
                                .data.documents[index].data['user-mail']),
                          )
                        : Text(''));
            }),
      ),
    );
  }
}
