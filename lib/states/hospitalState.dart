import 'package:flutter/material.dart';
import 'package:smart_ambulance/model/distance.dart';
import 'package:smart_ambulance/model/hospitalsInfo.dart';
import 'package:smart_ambulance/requests/google_request.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:smart_ambulance/states/crudState.dart';

class HospitalState with ChangeNotifier {
  GoogleMapsServices _googleMapsServices = GoogleMapsServices();
  CRUDState crudState = new CRUDState();
  List<HospitalsInfo> _list;
  List<HospitalsInfo> get list => _list;
  List<Distance> _listDistance = List<Distance>();
  List<Distance> get listDistance => _listDistance;

  HospitalState() {
    showHospitals();
  }

  Future<List<HospitalsInfo>> showHospitals() async {
    return _list = await crudState.fetchHospitals();
  }

  Future<List<Distance>> showDistance(LatLng l1) async {
    for (int i = 0; i < _list.length; i++) {
      Distance item = await _googleMapsServices.getMatrixDistance(
          l1, LatLng(_list[i].latitude, _list[i].longitude));
      _listDistance.add(new Distance(item.destinationAddress,
          item.originAddress, item.distance, item.duration));

      _listDistance.sort((a, b) => a.duration.compareTo(b.duration));
    }

    return _listDistance;
  }
}
