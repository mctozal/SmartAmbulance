import 'package:google_maps_flutter/google_maps_flutter.dart';

class AnimateToUser {
  GoogleMapController mapController;

  animeteToUser(lat, lon) async {
    mapController.animateCamera(
      CameraUpdate.newCameraPosition(CameraPosition(
        target: LatLng(lat, lon),
        zoom: 15.0,
      )),
    );
  }
}
