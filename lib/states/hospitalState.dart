import 'package:flutter/material.dart';
import 'package:smart_ambulance/model/distance.dart';
import 'package:smart_ambulance/model/location.dart';
import 'package:smart_ambulance/requests/google_request.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class HospitalState with ChangeNotifier {
  GoogleMapsServices _googleMapsServices = GoogleMapsServices();
  List<LocationHospital> _list;
  List<LocationHospital> get list => _list;
  List<Distance> _listDistance = List<Distance>();
  List<Distance> get listDistance => _listDistance;

  HospitalState() {
    showHospitals();
  }

  Future<List<LocationHospital>> showHospitals() async {
    return _list = await _googleMapsServices.getHospitals();
  }

  Future<List<Distance>> showDistance(LatLng l1) async {
    for(int i =0 ; i<_list.length; i++){
     Distance item = await _googleMapsServices.getMatrixDistance(
          l1, LatLng(_list[i].latitude, _list[i].longitude));
      _listDistance.add(new Distance(item.destinationAddress,item.distance,item.duration,item.originAddress));
    }
    return _listDistance;
  }
}
