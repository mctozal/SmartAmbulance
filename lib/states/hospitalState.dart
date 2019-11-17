import 'package:flutter/material.dart';
import 'package:smart_ambulance/core/model/location.dart';
import 'package:smart_ambulance/core/requests/google_request.dart';

class HospitalState with ChangeNotifier {
  GoogleMapsServices _googleMapsServices = GoogleMapsServices();
  List<LocationHospital> _list;

  List<LocationHospital> get list => _list;

  HospitalState() {
    showHospitals();
  }

  Future<List<LocationHospital>> showHospitals() async {
    return _list = await _googleMapsServices.getHospitals();
  }
}
