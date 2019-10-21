import 'package:location/location.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smart_ambulance/requests/google_request.dart';
import 'package:smart_ambulance/states/addMarker.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'createRoot.dart';

// Function to send GeoPoint to Firestore .
class AddGeoPoint {
  final createRoot = CreateRoot();
  Location location = new Location();
  Firestore fireStore = Firestore.instance;
  Geoflutterfire geo = Geoflutterfire();
  final addMarker = AddMarker();
  final getRootCoordinates = GoogleMapsServices();
  // final addRoute = AddRoute(); // will change

  Future<DocumentReference> addGeoPoint() async {
    var pos = await location.getLocation();
    GeoFirePoint point =
        geo.point(latitude: pos.latitude, longitude: pos.longitude);

    addMarker.addMarker(pos.latitude, pos.longitude);

    LatLng _initialPosition = LatLng(pos.latitude, pos.longitude);
    LatLng destination = LatLng(41.036945, 28.985832);

    String route = await getRootCoordinates.getRouteCoordinates(
        _initialPosition, destination);

    createRoot.createRoute(route);

    // addRoute(pos.latitude, pos.longitude);

    return fireStore
        .collection('locations')
        .add({'position': point.data, 'name': 'We can query'});
  }
}
