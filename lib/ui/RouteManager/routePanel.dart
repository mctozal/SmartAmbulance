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
    final managerState = Provider.of<ManagerState>(context);
    QuerySnapshot user = managerState.users;
    return Scaffold(
        body: Column(
      children: <Widget>[
        Container(
          height: 200,
          width: 500,
          alignment: Alignment.center,
          child: new Userlist(user: user),
        ),
      ],
    ));
  }
}

class Userlist extends StatelessWidget {
  const Userlist({Key key, @required this.user}) : super(key: key);

  final QuerySnapshot user;

  @override
  Widget build(BuildContext context) {
    if(user != null){
           bool checked = false;
          return ListView.builder(
            itemCount: user.documents.length,
            padding: EdgeInsets.all(5),
            itemBuilder: (context, i) {
              return ListTile(   
                leading: Checkbox(value: checked,onChanged: (value){ checked=value; },),
                title: Text(user.documents[i].data['user-mail']),
                subtitle: Text(user.documents[i].data['role']),
              );
            },
          );
          }
         return CircularProgressIndicator();
  }
}
