import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:flutter/widgets.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

const apiKey = "AIzaSyDjJdyuszYbdiK3eW6OFyx9uyNszjPBlyk";

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
    mapController.animateCamera(
      CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(lat, lon),
        zoom: 15.0,
      )),
    );
  }

  _addRoute(lat, lon) async {
    LatLng _initialPosition = LatLng(lat, lon);
    LatLng destination = LatLng(41.036945, 28.985832);
    String route = await getRouteCoordinates(_initialPosition, destination);
    setState(() {
      Polyline polyline = Polyline(
        polylineId: PolylineId('first'),
        visible: true,
        color: Colors.blue,
        points: _convertToLatLng(_decodePoly(route)),
      );
      _polyLines.add(polyline);

      Marker marker2 = Marker(
        markerId: MarkerId("mymarker2"),
        infoWindow: InfoWindow(title: 'Hospital'),
        visible: true,
        draggable: true,
        icon: BitmapDescriptor.defaultMarker,
        position: destination,
      );
      markers.add(marker2);
    });
    _animeteToUser(lat, lon);
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
    _addRoute(pos.latitude, pos.longitude);
    return fireStore
        .collection('locations')
        .add({'position': point.data, 'name': 'We can query'});
  }

  void createRoute(String encondedPoly) {
    setState(() {
      _polyLines.add(Polyline(
          polylineId: PolylineId('first'),
          width: 10,
          points: _convertToLatLng(_decodePoly(encondedPoly)),
          color: Colors.black));
    });
  }

  List _decodePoly(String poly) {
    var list = poly.codeUnits;
    var lList = new List();
    int index = 0;
    int len = poly.length;
    int c = 0;
// repeating until all attributes are decoded
    do {
      var shift = 0;
      int result = 0;

      // for decoding value of one attribute
      do {
        c = list[index] - 63;
        result |= (c & 0x1F) << (shift * 5);
        index++;
        shift++;
      } while (c >= 32);
      /* if value is negetive then bitwise not the value */
      if (result & 1 == 1) {
        result = ~result;
      }
      var result1 = (result >> 1) * 0.00001;
      lList.add(result1);
    } while (index < len);

/*adding to previous value as done in encoding */
    for (var i = 2; i < lList.length; i++) lList[i] += lList[i - 2];

    print(lList.toString());

    return lList;
  }

  List<LatLng> _convertToLatLng(List points) {
    List<LatLng> result = <LatLng>[];
    for (int i = 0; i < points.length; i++) {
      if (i % 2 != 0) {
        result.add(LatLng(points[i - 1], points[i]));
      }
    }
    return result;
  }

  void sendRequest(String intendedLocation) async {
    var pos = await location.getLocation();
    LatLng _initialPosition = LatLng(pos.latitude, pos.longitude);

    LatLng destination = LatLng(40.990178, 28.8233053);
    String route = await getRouteCoordinates(_initialPosition, destination);
    createRoute(route);
  }

  Future<String> getRouteCoordinates(LatLng l1, LatLng l2) async {
    String url =
        "https://maps.googleapis.com/maps/api/directions/json?origin=${l1.latitude},${l1.longitude}&destination=${l2.latitude},${l2.longitude}&key=$apiKey";
    http.Response response = await http.get(url);
    Map values = jsonDecode(response.body);
    return values["routes"][0]["overview_polyline"]["points"];
  }
}
