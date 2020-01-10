import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:smart_ambulance/model/distance.dart';
import 'dart:convert';

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
        "https://maps.googleapis.com/maps/api/place/textsearch/json?query=devlethastanesi+in+Istanbul&key=$apiKey";
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
          data[i]["geometry"]["location"]["lat"],
          data[i]["geometry"]["location"]["lng"],
          data[i]["id"],
          data[i]["name"],
          data[i]["rating"].toString(),
          data[i]["icon"],
          data[i]["formatted_address"]));
      crudState.addHospital(user, user.id);
    }

    return hospitals;
  }
*/

  Future<Distance> getMatrixDistance(LatLng l1, LatLng l2) async {
    final String url =
        "https://maps.googleapis.com/maps/api/distancematrix/json?units=imperial&origins=${l1.latitude},${l1.longitude}&destinations=${l2.latitude},${l2.longitude}&key=$apiKey";
    http.Response response = await http.get(url);
    Map data = json.decode(response.body);

    return Distance(
        data['destination_addresses'].toString(),
        data['origin_addresses'].toString(),
        '',
        data['rows'][0]['elements'][0]['distance']['value'],
        data['rows'][0]['elements'][0]['duration']['value']);
  }
}
