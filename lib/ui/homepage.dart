import 'package:flutter/material.dart';
import 'package:smart_ambulance/ui/hospitalList.dart';
import 'package:smart_ambulance/ui/filter.dart';
import 'firemap.dart';
import 'settings.dart';

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
