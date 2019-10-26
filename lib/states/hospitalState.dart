import 'package:flutter/material.dart';
import 'package:smart_ambulance/model/location.dart';
import 'package:smart_ambulance/requests/google_request.dart';

class HospitalState with ChangeNotifier {
  static bool _traffic;

  GoogleMapsServices _googleMapsServices = GoogleMapsServices();
  List<LocationHospital> _list;

  bool get traffic => _traffic = true;
  List<LocationHospital> get list => _list;

  HospitalState() {
    showHospitals();
  }

  Future<List<LocationHospital>> showHospitals() async {
    return _list = await _googleMapsServices.getHospitals();
  }

  
}
