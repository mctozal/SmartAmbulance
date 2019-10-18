import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class FireMap extends StatefulWidget {
  @override
  _FireMapState createState() => _FireMapState();
}

class _FireMapState extends State<FireMap> {
  GoogleMapController mapController;
  Location location = new Location();
  List<Marker> allMarkers = [];

  
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
          markers: Set.from(allMarkers),
        ),
        Positioned(
          bottom: 20,
          right: 10,
          child: FlatButton(
            shape: RoundedRectangleBorder(
                borderRadius: new BorderRadius.circular(100.0)),
            child: Icon(Icons.pin_drop, color: Colors.white),
            color: Colors.blue,
            onPressed: _addMarker,
          ),
        )
      ],
    );
  }

  _onMapCreated(GoogleMapController controller) {
    setState(() {
      mapController = controller;
    });
  }

  _animeteToUser() async {
    var pos = await location.getLocation();
    mapController.animateCamera(
      CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(pos.latitude, pos.longitude),
        zoom: 17.0,
      )),
    );
  }

  _addMarker() async {
    var pos = await location.getLocation();
    allMarkers.add(Marker(
      markerId: MarkerId("mymarker"),
      visible: true,
      draggable: true,
      icon: BitmapDescriptor.defaultMarker,
      position: LatLng(pos.latitude, pos.longitude),
    ));

     _animeteToUser();

  }
}
