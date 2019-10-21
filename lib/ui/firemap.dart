import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:flutter/widgets.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smart_ambulance/states/addGeoPoint.dart';

class FireMap extends StatefulWidget {
  @override
  _FireMapState createState() => _FireMapState();
}

class _FireMapState extends State<FireMap> {
  GoogleMapController mapController;
  Location location = new Location();

  Firestore fireStore = Firestore.instance;
  Geoflutterfire geo = Geoflutterfire();
  final Set<Marker> markers = {};
  final Set<Polyline> _polyLines = {};

  final addGeoPoint = AddGeoPoint();

  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        GoogleMap(
          initialCameraPosition:
              CameraPosition(target: LatLng(40.990178, 28.8233053), zoom: 15),
          onMapCreated: _onMapCreated,
          myLocationButtonEnabled: true,
          mapType: MapType.normal,
          polylines: _polyLines,
          compassEnabled: true,
          markers: markers,
        ),
        Positioned(
          bottom: 20,
          right: 10,
          child: FlatButton(
            shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(100.0)),
            child: Icon(Icons.pin_drop, color: Colors.white),
            color: Colors.blue,
            onPressed: AddGeoPoint().addGeoPoint,
          ),
        )
      ],
    );
  }

  // Its an instance when map created, controller exists.

  _onMapCreated(GoogleMapController controller) {
    setState(() {
      mapController = controller;
    });
  }

  
}
