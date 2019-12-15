import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart' as locationa;
import 'package:flutter/widgets.dart';
import 'package:geoflutterfire/geoflutterfire.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:smart_ambulance/model/distance.dart';
import 'package:smart_ambulance/model/location.dart';
import 'package:smart_ambulance/model/users.dart';
import 'package:smart_ambulance/requests/google_request.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:smart_ambulance/src/convertToLatLng.dart';
import 'package:smart_ambulance/src/decodePoly.dart';
import 'package:smart_ambulance/states/crudState.dart';

const _apiKey = "AIzaSyDjJdyuszYbdiK3eW6OFyx9uyNszjPBlyk";

class MapState with ChangeNotifier {
  static LatLng _initialPosition;
  LatLng _lastPosition = _initialPosition;
  final Set<Marker> _markers = {};
  final Set<Polyline> _polyLines = {};
  bool _traffic = false;
  CRUDState crudState = new CRUDState();
  GoogleMapController _mapController;
  GoogleMapsServices _googleMapsServices = GoogleMapsServices();
  locationa.Location location = new locationa.Location();
  TextEditingController destinationController = TextEditingController();
  GoogleMapsPlaces places = GoogleMapsPlaces(apiKey: _apiKey);
  DecodePoly decode = new DecodePoly();
  ConvertToLatLng convert = new ConvertToLatLng();

  LatLng get initialPosition => _initialPosition;
  LatLng get lastPosition => _lastPosition;
  bool get traffic => _traffic;
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

  checkTraffic(traffic) {
    _traffic = traffic;
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

  Future<DocumentReference> addGeoPoint(String uid) {
    GeoFirePoint point = geo.point(
        latitude: _initialPosition.latitude,
        longitude: _initialPosition.longitude);
    DateTime time = DateTime.now();
    addMarker();
    User userlocation = User(position: point, time: time);
    return crudState.updateProduct(userlocation, uid);
    // return fireStore
    //     .collection('users').document(uid).updateData({'position': point.data, 'time':time});
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
        points: convert.convertToLatLng(decode.decodePoly(encondedPoly)),
        color: Colors.blue));
    notifyListeners();
  }

  void sendRequest(Prediction intendedLocation, context) async {
    if (intendedLocation != null) {
      PlacesDetailsResponse detail =
          await places.getDetailsByPlaceId(intendedLocation.placeId);
      double lat = detail.result.geometry.location.lat;
      double lng = detail.result.geometry.location.lng;
      LatLng destination = LatLng(lat, lng);

      String route = await _googleMapsServices.getRouteCoordinates(
          _initialPosition, destination);
      Distance distance = await _googleMapsServices.getMatrixDistance(
          _initialPosition, destination);

      Marker marker2 = Marker(
        markerId: MarkerId("mymarker2"),
        infoWindow: InfoWindow(title: 'Hospital'),
        visible: true,
        draggable: true,
        onTap: () {
          showDialog(
              context: context,
              builder: (_) => AlertDialog(title: Text(distance.duration)));
          return;
        },
        icon: BitmapDescriptor.defaultMarker,
        position: destination,
      );
      _markers.add(marker2);

      createRoute(route);
    }
    notifyListeners();
  }

  createRouteToHospital(LatLng destination) async {
    String route = await _googleMapsServices.getRouteCoordinates(
        _initialPosition, destination);
    createRoute(route);
    notifyListeners();
  }

  showAmbulances(BuildContext context) async {
    List<LocationHospital> list = List<LocationHospital>();

    list.add(new LocationHospital(40.996107, 28.866550, "1", "Ambulance1"));
    list.add(new LocationHospital(40.995109, 28.863828, "2", "Ambulance2"));
    list.add(new LocationHospital(40.989785, 28.851911, "3", "Ambulance3"));
    list.add(new LocationHospital(41.000134, 28.866931, "4", "Ambulance4"));
    list.add(new LocationHospital(41.005151, 28.868954, "5", "Ambulance5"));
    list.add(new LocationHospital(41.014471, 28.862007, "6", "Ambulance6"));
    list.add(new LocationHospital(41.010983, 28.876609, "7", "Ambulance7"));
    list.add(new LocationHospital(41.006207, 28.880256, "8", "Ambulance8"));
    list.add(new LocationHospital(41.001592, 28.870901, "9", "Ambulance9"));
    list.add(new LocationHospital(40.987848, 28.872178, "10", "Ambulance10"));

    for (var i = 0; i < list.length; i++) {
      final MarkerId markerId = MarkerId(list[i].id);
      final Marker marker = Marker(
        markerId: markerId,
        visible: true,
        infoWindow: InfoWindow(title: list[i].name),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueCyan),
        draggable: false,
        consumeTapEvents: true,
        onTap: () {
          showDialog(
              context: context,
              builder: (_) => AlertDialog(
                    title: Text(
                      'Routing',
                      style: TextStyle(
                          fontSize: 22.0, fontWeight: FontWeight.w600),
                    ),
                    content: Text("Do you want to go to ${list[i].name} ?"),
                    actions: <Widget>[
                      Image(
                        height: 100,
                        width: 100,
                        image: AssetImage('images/hospital.png'),
                      ),
                      FlatButton(
                        child: Icon(Icons.close),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                      FlatButton(
                        child: Icon(Icons.done),
                        onPressed: () async {
                          await createRouteToHospital(
                              LatLng(list[i].latitude, list[i].longitude));
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ));
          return;
        },
        position: LatLng(
          list[i].latitude,
          list[i].longitude,
        ),
      );
      _markers.add(marker);
      _mapController.animateCamera(
        CameraUpdate.newCameraPosition(CameraPosition(
          target: LatLng(_initialPosition.latitude, _initialPosition.longitude),
          zoom: 12.0,
        )),
      );
    }
     notifyListeners();
  }


  showEmergency(BuildContext context) async {
    List<LocationHospital> list = List<LocationHospital>();

    list.add(new LocationHospital(40.986429,28.876541, "1", "Emergency1"));
    list.add(new LocationHospital(40.995109, 28.864500, "2", "Emergency2"));
    list.add(new LocationHospital(40.989785, 28.852420, "3", "Emergency3"));
    list.add(new LocationHospital(41.000134, 28.867500, "4", "Emergency4"));
    list.add(new LocationHospital(41.005151, 28.867222, "5", "Emergency5"));
    list.add(new LocationHospital(41.014471, 28.863075, "6", "Emergency6"));
    list.add(new LocationHospital(41.010983, 28.875200, "7", "Emergency7"));
    list.add(new LocationHospital(41.006207, 28.881124, "8", "Emergency8"));
    list.add(new LocationHospital(41.001592, 28.871111, "9", "Emergency9"));
    list.add(new LocationHospital(40.987848, 28.873666, "10", "Emergency10"));

    for (var i = 0; i < list.length; i++) {
      final MarkerId markerId = MarkerId(list[i].id);
      final Marker marker = Marker(
        markerId: markerId,
        visible: true,
        infoWindow: InfoWindow(title: list[i].name),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueRose),
        draggable: false,
        consumeTapEvents: true,
        onTap: () {
          showDialog(
              context: context,
              builder: (_) => AlertDialog(
                    title: Text(
                      'Routing',
                      style: TextStyle(
                          fontSize: 22.0, fontWeight: FontWeight.w600),
                    ),
                    content: Text("Do you want to go to ${list[i].name} ?"),
                    actions: <Widget>[
                      Image(
                        height: 100,
                        width: 100,
                        image: AssetImage('images/hospital.png'),
                      ),
                      FlatButton(
                        child: Icon(Icons.close),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                      FlatButton(
                        child: Icon(Icons.done),
                        onPressed: () async {
                          await createRouteToHospital(
                              LatLng(list[i].latitude, list[i].longitude));
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ));
          return;
        },
        position: LatLng(
          list[i].latitude,
          list[i].longitude,
        ),
      );
      _markers.add(marker);
      _mapController.animateCamera(
        CameraUpdate.newCameraPosition(CameraPosition(
          target: LatLng(_initialPosition.latitude, _initialPosition.longitude),
          zoom: 12.0,
        )),
      );
    }
     notifyListeners();
  }

  showHospitals(BuildContext context) async {
    List<LocationHospital> list = await _googleMapsServices.getHospitals();

    for (var i = 0; i < list.length; i++) {
      final MarkerId markerId = MarkerId(list[i].id);
      final Marker marker = Marker(
        markerId: markerId,
        visible: true,
        infoWindow: InfoWindow(title: list[i].name),
        icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueGreen),
        draggable: false,
        consumeTapEvents: true,
        onTap: () {
          showDialog(
              context: context,
              builder: (_) => AlertDialog(
                    title: Text(
                      'Routing',
                      style: TextStyle(
                          fontSize: 22.0, fontWeight: FontWeight.w600),
                    ),
                    content: Text("Do you want to go to ${list[i].name} ?"),
                    actions: <Widget>[
                      Image(
                        height: 100,
                        width: 100,
                        image: AssetImage('images/hospital.png'),
                      ),
                      FlatButton(
                        child: Icon(Icons.close),
                        onPressed: () => Navigator.of(context).pop(),
                      ),
                      FlatButton(
                        child: Icon(Icons.done),
                        onPressed: () async {
                          await createRouteToHospital(
                              LatLng(list[i].latitude, list[i].longitude));
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ));
          return;
        },
        position: LatLng(
          list[i].latitude,
          list[i].longitude,
        ),
      );
      _markers.add(marker);
      _mapController.animateCamera(
        CameraUpdate.newCameraPosition(CameraPosition(
          target: LatLng(_initialPosition.latitude, _initialPosition.longitude),
          zoom: 12.0,
        )),
      );
    }
    notifyListeners();
  }
}
