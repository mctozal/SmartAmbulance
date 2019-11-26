import 'package:flutter/material.dart';
import 'package:smart_ambulance/model/distance.dart';
import 'package:smart_ambulance/model/location.dart';
import 'package:smart_ambulance/requests/google_request.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HospitalState with ChangeNotifier {
  GoogleMapsServices _googleMapsServices = GoogleMapsServices();
  List<LocationHospital> _list;
  List<LocationHospital> get list => _list;
  Distance _listDistance;
  Distance get listDistance => _listDistance;

  HospitalState() {
    showHospitals();
  }

  Future<List<LocationHospital>> showHospitals() async {
    return _list = await _googleMapsServices.getHospitals();
  }

  Future<Distance> showDistance(LatLng l1,LatLng l2) async {
    return _listDistance = await _googleMapsServices.getMatrixDistance(l1, l2);
  }

}
