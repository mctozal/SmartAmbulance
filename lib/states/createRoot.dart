import 'package:flutter/material.dart';
import 'package:smart_ambulance/states/convertToLatLng.dart';
import 'package:smart_ambulance/states/decodePoly.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/widgets.dart';

class CreateRoot extends StatefulWidget {
  @override
  _CreateRootState createState() => _CreateRootState();
  String encondedPoly;
  void createRoute(encondedPoly) =>
      _CreateRootState().createRoute(encondedPoly);
}

class _CreateRootState extends State<CreateRoot> {
  final decodePoly = DecodePoly();
  final convertToLatLng = ConvertToLatLng();
  final Set<Polyline> _polyLines = {};

  void createRoute(String encondedPoly) {
    setState(() {
      _polyLines.add(Polyline(
          polylineId: PolylineId('first'),
          width: 10,
          points: convertToLatLng
              .convertToLatLng(decodePoly.decodePoly(encondedPoly)),
          color: Colors.black));
    });
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return null;
  }
}
