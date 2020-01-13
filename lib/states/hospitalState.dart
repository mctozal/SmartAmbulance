import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_ambulance/model/distance.dart';
import 'package:smart_ambulance/model/hospitalsInfo.dart';
import 'package:smart_ambulance/requests/google_request.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:smart_ambulance/src/distanceCalculator.dart';
import 'package:smart_ambulance/states/crudState.dart';
import 'package:smart_ambulance/states/mapState.dart';
import 'package:smart_ambulance/ui/firemap.dart';

class HospitalState with ChangeNotifier {
  GoogleMapsServices _googleMapsServices = GoogleMapsServices();
  DistanceCalculator distanceCalculator = new DistanceCalculator();
  CRUDState crudState = new CRUDState();
  List<HospitalsInfo> _list;
  List<HospitalsInfo> get list => _list;
  List<Distance> _listDistance = List<Distance>();
  List<Distance> get listDistance => _listDistance;
  List<Distance> get listDistanceCalculated => _listDistance;

  HospitalState() {
    showHospitals();
  }

  Future<List<HospitalsInfo>> showHospitals() async {
    return _list = await crudState.fetchHospitals();
  }

  Future<List<Distance>> showDistance(LatLng l1) async {
    for (int i = 0; i < _list.length; i++) {
      double meter = distanceCalculator.calculate(
          l1.latitude, l1.longitude, _list[i].latitude, _list[i].longitude);
      if (meter < 5000) {
        Distance item = await _googleMapsServices.getMatrixDistance(
            l1, LatLng(_list[i].latitude, _list[i].longitude));
        _listDistance.add(new Distance(item.destinationAddress,
            item.originAddress, _list[i].id, item.distance, item.duration));
        _listDistance.sort((a, b) => a.duration.compareTo(b.duration));
      }
    }
    return _listDistance;
  }

  showDetailedHospital(destinationId, context) {
    for (int i = 0; i < _list.length; i++) {
      if (_list[i].id == destinationId) {
        showDialog(
            context: context,
            builder: (_) => AlertDialog(
                  title: Text(
                    'Routing',
                    style:
                        TextStyle(fontSize: 22.0, fontWeight: FontWeight.w600),
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
                        final mapState =
                            Provider.of<MapState>(context, listen: false);
                        await mapState.createRouteToHospital(
                            LatLng(list[i].latitude, list[i].longitude));
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) => FireMap()));
                      },
                    ),
                  ],
                ));
      }
    }
    return;
  }
}
