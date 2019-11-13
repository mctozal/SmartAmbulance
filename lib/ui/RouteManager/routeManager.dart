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
          elevation: 2.0,
          title: Text('Dashboard',
              style: TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 20.0)),
          actions: <Widget>[
            Container(
              margin: EdgeInsets.only(right: 8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Text('Smart Ambulance',
                      style: TextStyle(
                          fontWeight: FontWeight.w700,
                          fontSize: 14.0)),
                  Icon(Icons.arrow_drop_down),
                  IconButton(
                    icon: Icon(
                      Icons.more_vert,
                    ),
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SettingsUI()));
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
        body: RoutePanel());
  }
}
