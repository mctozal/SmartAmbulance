import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Smart Ambulance'),
        ),
        body: FireMap());
  }
}

class FireMap extends StatefulWidget {
  @override
  _FireMapState createState() => _FireMapState();
}

class _FireMapState extends State<FireMap> {
  @override
  Widget build(BuildContext context) {
    return Stack(children: <Widget>[
      GoogleMap(
        initialCameraPosition: CameraPosition(
          target: LatLng(24.142,-110.321),
          zoom:15
        ),

      )
    ],);
  }
}
