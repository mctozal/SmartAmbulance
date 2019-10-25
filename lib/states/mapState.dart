import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as locationa;
import 'package:flutter/widgets.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smart_ambulance/model/location.dart';
import 'package:smart_ambulance/requests/google_request.dart';
import 'package:google_maps_webservice/places.dart';

const _apiKey = "AIzaSyDjJdyuszYbdiK3eW6OFyx9uyNszjPBlyk";

class MapState with ChangeNotifier {
  static LatLng _initialPosition;
  LatLng _lastPosition = _initialPosition;
  final Set<Marker> _markers = {};
  final Set<Polyline> _polyLines = {};
  bool _traffic;

  GoogleMapController _mapController;
  GoogleMapsServices _googleMapsServices = GoogleMapsServices();
  locationa.Location location = new locationa.Location();
  TextEditingController destinationController = TextEditingController();
  GoogleMapsPlaces places = GoogleMapsPlaces(apiKey: _apiKey);

  LatLng get initialPosition => _initialPosition;
  LatLng get lastPosition => _lastPosition;
  bool get traffic => _traffic=true;
  String get apiKey => _apiKey;
  GoogleMapsServices get googleMapsServices => _googleMapsServices;
  GoogleMapController get mapController => _mapController;
  Set<Marker> get marker => _markers;
  Set<Polyline> get polyLines => _polyLines;
  Firestore fireStore = Firestore.instance;
  Geoflutterfire geo = Geoflutterfire();

  MapState() {
    getUserLocation();
  }

  getUserLocation() async {
    var pos = await location.getLocation();
    _initialPosition = LatLng(pos.latitude, pos.longitude);
    notifyListeners();
  }

  onMapCreated(GoogleMapController controller) {
    _mapController = controller;
    notifyListeners();
  }

  checkTraffic() {
    if (_traffic == null) {
      _traffic = true;
    } else if (_traffic == false) {
      _traffic = true;
    } else if (_traffic == true) {
      _traffic = false;
    }
    notifyListeners();
  }

  animeteToUser() async {
    _mapController.animateCamera(
      CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(_initialPosition.latitude, _initialPosition.longitude),
        zoom: 15.0,
      )),
    );
    notifyListeners();
  }

  // Function to send GeoPoint to Firestore .

  Future<DocumentReference> addGeoPoint() {
    GeoFirePoint point = geo.point(
        latitude: _initialPosition.latitude,
        longitude: _initialPosition.longitude);

    addMarker();
    return fireStore
        .collection('locations')
        .add({'position': point.data, 'name': 'We can query'});
  }

  // Adding a marker to map

  addMarker() async {
    Marker marker = Marker(
      markerId: MarkerId("mymarker"),
      visible: true,
      draggable: true,
      icon: BitmapDescriptor.defaultMarker,
      position: LatLng(_initialPosition.latitude, _initialPosition.longitude),
    );
    _markers.add(marker);
    animeteToUser();
    notifyListeners();
  }

  void createRoute(String encondedPoly) {
    _polyLines.add(Polyline(
        polylineId: PolylineId('first'),
        width: 10,
        points: _convertToLatLng(_decodePoly(encondedPoly)),
        color: Colors.blue));
    notifyListeners();
  }

  void sendRequest(Prediction intendedLocation) async {
    if (intendedLocation != null) {
      PlacesDetailsResponse detail =
          await places.getDetailsByPlaceId(intendedLocation.placeId);
      double lat = detail.result.geometry.location.lat;
      double lng = detail.result.geometry.location.lng;
      LatLng destination = LatLng(lat, lng);

      String route = await _googleMapsServices.getRouteCoordinates(
          _initialPosition, destination);

      Marker marker2 = Marker(
        markerId: MarkerId("mymarker2"),
        infoWindow: InfoWindow(title: 'Hospital'),
        visible: true,
        draggable: true,
        icon: BitmapDescriptor.defaultMarker,
        position: destination,
      );
      _markers.add(marker2);

      createRoute(route);
      animeteToUser();
    }
    notifyListeners();
  }

  int generateIds() {
    var rng = new Random();
    var randomInt;
    randomInt = rng.nextInt(100);
    print(rng.nextInt(100));
    return randomInt;
  }

  createRouteToHospital(LatLng destination) async {
    String route = await _googleMapsServices.getRouteCoordinates(
        _initialPosition, destination);
    createRoute(route);
    notifyListeners();
  }

  showHospitals() async {
    List<LocationHospital> list = await _googleMapsServices.getHospitals();

    for (var i = 0; i < list.length; i++) {
      var markerIdVal = generateIds();
      final MarkerId markerId = MarkerId(markerIdVal.toString());
      final Marker marker = Marker(
        markerId: markerId,
        visible: true,
        infoWindow: InfoWindow(title: 'Hospital'),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        draggable: true,
        consumeTapEvents: true,
        onTap: () async {
          await createRouteToHospital(LatLng(list[i].lat, list[i].lng));
        },
        position: LatLng(
          list[i].lat,
          list[i].lng,
        ),
      );
      _markers.add(marker);
    }
    notifyListeners();
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
}
