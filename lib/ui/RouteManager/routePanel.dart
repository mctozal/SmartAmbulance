import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smart_ambulance/states/managerState.dart';

class RoutePanel extends StatefulWidget {
  @override
  _RoutePanelState createState() => _RoutePanelState();
}

class _RoutePanelState extends State<RoutePanel> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Column(
      children: <Widget>[
        Container(
          height: 200,
          width: 500,
          alignment: Alignment.center,
          child: new Userlist(),
        ),
      ],
    ));
  }
}

class Userlist extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final managerState = Provider.of<ManagerState>(context);
    if (managerState.showUsers().first != null &&
        managerState.showLocations().first != null) {
      bool checked = false;
      return StreamBuilder<QuerySnapshot>(
          stream: managerState.showUsers(),
          builder: (context, snapshot) {
            return ListView.builder(
              itemCount: snapshot.data.documents.length,
              padding: EdgeInsets.all(5),
              itemBuilder: (context, i) {
                return ListTile(
                  onTap: () {
                    showDialog(
                        context: context,
                        builder: (_) => StreamBuilder<QuerySnapshot>(
                            stream: managerState.showLocations(),
                            builder: (context, snapshot) {
                              return ListView.builder(
                                itemCount: snapshot.data.documents.length,
                                padding: EdgeInsets.all(5),
                                itemBuilder: (context, i) {
                                  return Scaffold(
                                    appBar: AppBar(
                                      title: Text('Locations'),
                                    ),
                                    body: Text(
                                        snapshot.data.documents[i].data['uid']),
                                  );
                                },
                              );
                            }));
                  },
                  leading: Checkbox(
                    value: checked,
                    onChanged: (value) {
                      checked = value;
                    },
                  ),
                  title: Text(snapshot.data.documents[i].data['user-mail']),
                  subtitle: Text(snapshot.data.documents[i].data['role']),
                );
              },
            );
          });
    }
    return CircularProgressIndicator();
  }
}
