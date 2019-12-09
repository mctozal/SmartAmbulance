import 'package:flutter/material.dart';
import 'package:smart_ambulance/ui/hospitalList.dart';
import 'firemap.dart';
import 'settings.dart';
/*
class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.location_on,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => HospitalUI()),
                );
              },
            ),
            IconButton(
              icon: Icon(
                Icons.more_vert,
                color: Colors.white,
              ),
              onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (context)=> SettingsUI()));},
            ),
          ],
          title: Text(
            'Smart Ambulance',
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ),
        body: FireMap());
  }
}
*/

import 'package:firebase_auth/firebase_auth.dart';

class MyHome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MyHomePage(title: 'Flutter Demo Home Page');
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            RaisedButton(
              child: Text('Logout'),
              onPressed: () async {
                await _auth.signOut();
                Navigator.of(context).pushReplacementNamed('/loginpage');
              },
            ),
          ],
        ),
      ),
    );
  }
}