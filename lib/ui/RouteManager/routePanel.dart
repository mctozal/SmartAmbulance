import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';


String email = 'Select an e-mail';

class RoutePanel extends StatefulWidget {
  @override
  _RoutePanelState createState() => _RoutePanelState();
}

class _RoutePanelState extends State<RoutePanel> {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<FirebaseUser>(
      stream: FirebaseAuth.instance.onAuthStateChanged,

      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.active) {
          FirebaseUser user = snapshot.data;
          List<UserInfo> userList = user.providerData;
         
          return DropdownButton(
              value: null,
              onChanged: (String newValue) {
                setState(() {
                  email = newValue;
                });
              },
              items: userList.map((userList) {
                return DropdownMenuItem<String>(
                  child: Text(userList.email),
                );
              }).toList());
        }
        return CircularProgressIndicator();
      },
    );
  }
}
