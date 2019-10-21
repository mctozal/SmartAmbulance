import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/widgets.dart';
import 'package:smart_ambulance/states/animateToUser.dart';

// Adding a marker to map
class AddMarker extends StatefulWidget {
  @override
  _AddMarkerState createState() => _AddMarkerState();
  double lat, lon;
  void addMarker(lat, lon) => _AddMarkerState().addMarker(lat, lon);
}

class _AddMarkerState extends State<AddMarker> {
  @override
  final Set<Marker> markers = {};
  final animateToUser = AnimateToUser();

  addMarker(lat, lon) async {
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
    animateToUser.animeteToUser(lat, lon);
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return null;
  }
}
