import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:smart_ambulance/requests/google_request.dart';
import 'package:smart_ambulance/states/createRoot.dart';

class SendRequest {
  final createRoute = CreateRoot();
  final getRouteCoordinates = GoogleMapsServices();

  Location location = new Location();
  void sendRequest(String intendedLocation) async {
    var pos = await location.getLocation();
    LatLng _initialPosition = LatLng(pos.latitude, pos.longitude);

    LatLng destination = LatLng(40.990178, 28.8233053);
    String route = await getRouteCoordinates.getRouteCoordinates(_initialPosition, destination);
    createRoute.createRoute(route);
  }
}
