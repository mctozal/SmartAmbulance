import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smart_ambulance/model/distance.dart';
import 'package:smart_ambulance/model/distanceMatrix.dart';
import 'package:smart_ambulance/model/hospitalsInfo.dart';
import 'package:smart_ambulance/requests/google_request.dart';
import 'package:google_maps_webservice/geolocation.dart';
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

  HospitalState() {}

  Future<List<HospitalsInfo>> showHospitals() async {
    return _list = await crudState.fetchHospitals();
  }

  String hospitalName(id) {
    String name = '';
    for (int i = 0; i < _list.length; i++) {
      if (id == _list[i].id) {
        name = _list[i].name;
      }
    }
    return name;
  }

  String hospitalNameAddress(id) {
    String name = '';
    for (int i = 0; i < _list.length; i++) {
      if (id == _list[i].formatted_address) {
        name = _list[i].name;
      }
    }
    return name;
  }

  LatLng destinationLatLng(id) {
    LatLng location;
    for (int i = 0; i < _list.length; i++) {
      if (id == _list[i].id) {
        location = LatLng(_list[i].latitude, _list[i].longitude);
      }
    }
    return location;
  }

  String surgeryRoom(String id) {
    String surgeryRoom;
    for (int i = 0; i < _list.length; i++) {
      if (id == _list[i].id) {
        surgeryRoom = _list[i].surgeryRoom;
      }
    }
    return surgeryRoom;
  }

  String availableDoctors(String id) {
    String availableDoctors;
    for (int i = 0; i < _list.length; i++) {
      if (id == _list[i].id) {
        availableDoctors = _list[i].availableDoctors;
      }
    }
    return availableDoctors;
  }

  String emergency(String id) {
    String emergency;
    for (int i = 0; i < _list.length; i++) {
      if (id == _list[i].id) {
        emergency = _list[i].emergency;
      }
    }
    return emergency;
  }

  String phone(String id) {
    String phone;
    for (int i = 0; i < _list.length; i++) {
      if (id == _list[i].id) {
        phone = _list[i].phone;
      }
    }
    return phone;
  }

  Future<List<Distance>> showDistance(LatLng l1) async {
    List<Location> listDest = List<Location>();
    if (_listDistance.isEmpty) {
      for (int i = 0; i < _list.length; i++) {
        double meter = distanceCalculator.calculate(
          l1.latitude,
          l1.longitude,
          _list[i].latitude,
          _list[i].longitude,
        );
        // String doctors=_list[i].availableDoctors;
        //String rooms=_list[i].surgeryRoom;

        if (meter < 5000) {
          listDest.add(Location(_list[i].latitude, _list[i].longitude));
        }
      }

      DistanceMatrix item =
          await _googleMapsServices.getMatrixDistance(l1, listDest);

      for (int i = 0; i < item.destination_addresses.length; i++) {
        if (item.rows[0]['elements'][i]['distance']['value'] < 5000) {
          _listDistance.add(new Distance(
              item.destination_addresses[i].toString(),
              item.origin_addresses[0].toString(),
              hospitalNameAddress(item.destination_addresses[i].toString()),
              _list[i].id,
              item.rows[0]['elements'][i]['distance']['value'],
              item.rows[0]['elements'][i]['duration']['value']));
        }
      }
    }
    _listDistance.sort((a, b) => a.duration.compareTo(b.duration));
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
