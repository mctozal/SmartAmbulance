import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:smart_ambulance/model/distance.dart';
import 'dart:convert';

import 'package:smart_ambulance/model/location.dart';

const apiKey = "AIzaSyDjJdyuszYbdiK3eW6OFyx9uyNszjPBlyk";

class GoogleMapsServices {
  Future<String> getRouteCoordinates(LatLng l1, LatLng l2) async {
    String url =
        "https://maps.googleapis.com/maps/api/directions/json?origin=${l1.latitude},${l1.longitude}&destination=${l2.latitude},${l2.longitude}&key=$apiKey";
    http.Response response = await http.get(url);
    Map values = jsonDecode(response.body);
    return values["routes"][0]["overview_polyline"]["points"];
  }

  Future<List<LocationHospital>> getHospitals() async {
    final String url =
        "https://maps.googleapis.com/maps/api/place/textsearch/json?query=hospitals+in+Turkey&key=$apiKey";
    http.Response response = await http.get(url);
    List data = json.decode(response.body)["results"];
    var locations = <LocationHospital>[];

    data.forEach((f) => locations.add(new LocationHospital(
        f["geometry"]["location"]["lat"],
        f["geometry"]["location"]["lng"],
        f["id"],
        f["name"])));

    return locations;
  }

  Future<Distance> getMatrixDistance(LatLng l1, LatLng l2) async {
    final String url =
        "https://maps.googleapis.com/maps/api/distancematrix/json?units=imperial&origins=${l1.latitude},${l1.longitude}&destinations=${l2.latitude},${l2.longitude}&key=$apiKey";
    http.Response response = await http.get(url);
    Map data = json.decode(response.body);

    return Distance(
        data['destination_addresses'].toString(),
        data['origin_addresses'].toString(),
        data['rows'][0]['elements'][0]['distance']['value'].toString(),
        data['rows'][0]['elements'][0]['duration']['value'].toString());
  }
}
