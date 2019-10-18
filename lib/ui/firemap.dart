import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

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

  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        GoogleMap(
          initialCameraPosition:
              CameraPosition(target: LatLng(40.990178, 28.8233053), zoom: 15),
          onMapCreated: _onMapCreated,
          myLocationButtonEnabled: true,
          mapType: MapType.normal,
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
            onPressed: _addGeoPoint,
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

  // gets camera to location.

  _animeteToUser(lat, lon) async {
    var pos = await location.getLocation();
    mapController.animateCamera(
      CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(lat, lon),
        zoom: 15.0,
      )),
    );
  }

  // Adding a marker to map

  _addMarker(lat, lon) async {
    setState(() {
      Marker marker = Marker(
        markerId: MarkerId("mymarker"),
        visible: true,
        draggable: true,
        icon: BitmapDescriptor.defaultMarker,
        position: LatLng(lat, lon),
      );
      markers.add(marker);
    });
    _animeteToUser(lat, lon);
  }

// Function to send GeoPoint to Firestore .

  Future<DocumentReference> _addGeoPoint() async {
    var pos = await location.getLocation();
    GeoFirePoint point =
        geo.point(latitude: pos.latitude, longitude: pos.longitude);

    _addMarker(pos.latitude, pos.longitude);

    return fireStore
        .collection('locations')
        .add({'position': point.data, 'name': 'We can query'});
  }
}
