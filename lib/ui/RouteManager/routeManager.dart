import 'package:flutter/material.dart';
import 'package:smart_ambulance/ui/RouteManager/routePanel.dart';

import '../settings.dart';

class RouteManager extends StatefulWidget {
  @override
  _RouteManagerState createState() => _RouteManagerState();
}

class _RouteManagerState extends State<RouteManager> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          actions: <Widget>[
            IconButton(
              icon: Icon(
                Icons.more_vert,
                color: Colors.white,
              ),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SettingsUI()));
              },
            ),
          ],
          title: Text(
            'Manager Panel',
            style: TextStyle(
              fontSize: 16,
            ),
          ),
        ),
        body: RoutePanel());
  }
}
