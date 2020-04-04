import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/geolocation.dart';
import 'package:http/http.dart' as http;
import 'package:smart_ambulance/model/distance.dart';
import 'dart:convert';

import 'package:smart_ambulance/model/distanceMatrix.dart';

const apiKey = "AIzaSyDjJdyuszYbdiK3eW6OFyx9uyNszjPBlyk";

class GoogleMapsServices {
  Future<String> getRouteCoordinates(LatLng l1, LatLng l2) async {
    String url =
        "https://maps.googleapis.com/maps/api/directions/json?origin=${l1.latitude},${l1.longitude}&destination=${l2.latitude},${l2.longitude}&key=$apiKey";
    http.Response response = await http.get(url);
    Map values = jsonDecode(response.body);
    return values["routes"][0]["overview_polyline"]["points"];
  }

/* Sadece hastane sayımızı ve bilgileri database'e alırken kulanacağız.
  Future<List<HospitalsInfo>> getHospitals() async {
    final String url =
        "https://maps.googleapis.com/maps/api/place/textsearch/json?query=hospital+in+Istanbul&key=$apiKey";
    http.Response response = await http.get(url);
    List data = json.decode(response.body)["results"];
    // var locations = <LocationHospital>[];
    var hospitals = <HospitalsInfo>[];
    CRUDState crudState = new CRUDState();
    /*
    data.forEach((f) => locations.add(new LocationHospital(
        f["geometry"]["location"]["lat"],
        f["geometry"]["location"]["lng"],                   // geri donen bilgi databaseden olmasi icin  turu ve ici degistirildi
        f["id"],
        f["name"])));
     */
    for (int i = 0; i < data.length; i++) {
      HospitalsInfo user;
      hospitals.add(user = new HospitalsInfo(
          latitude:data[i]["geometry"]["location"]["lat"],
          longitude:data[i]["geometry"]["location"]["lng"],
          id:data[i]["id"],
          name:data[i]["name"],
          rating:data[i]["rating"].toString(),
          icon:data[i]["icon"],
          formatted_address:data[i]["formatted_address"],
          surgeryRoom:'Not Available',
          availableDoctors:'Available',
          emergency:'available',
          phone:'tel:(0212)5232288',
          ));
      crudState.addHospital(user, user.id);
    }

    return hospitals;
  }
*/

  Future getMatrixDistance(LatLng l1, List<Location> l2) async {
    DistanceMatrix distanceMatrix;

    // King of Solution of Solution ***

    String destList = "";
    l2.forEach((f) =>
        destList = f.lat.toString() + "," + f.lng.toString() + "|" + destList);
        
    final String url =
        "https://maps.googleapis.com/maps/api/distancematrix/json?units=imperial&origins=${l1.latitude},${l1.longitude}&destinations=${destList}&key=$apiKey";
    http.Response response = await http.get(url);
    Map data = json.decode(response.body);
    distanceMatrix = DistanceMatrix.fromMap(data);
    return distanceMatrix;
  }
}
