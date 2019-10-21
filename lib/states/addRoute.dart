// import 'package:flutter/material.dart';
// import 'package:google_maps_flutter/google_maps_flutter.dart';

// class AddRoute{

// _addRoute(lat, lon) async {
//     LatLng _initialPosition = LatLng(lat, lon);
//     LatLng destination = LatLng(41.036945, 28.985832);
//     String route = await getRouteCoordinates(_initialPosition, destination);
//     setState(() {
//       Polyline polyline = Polyline(
//         polylineId: PolylineId('first'),
//         visible: true,
//         color: Colors.blue,
//         points: _convertToLatLng(_decodePoly(route)),
//       );
//       _polyLines.add(polyline);

//       Marker marker2 = Marker(
//         markerId: MarkerId("mymarker2"),
//         infoWindow: InfoWindow(title: 'Hospital'),
//         visible: true,
//         draggable: true,
//         icon: BitmapDescriptor.defaultMarker,
//         position: destination,
//       );
//       markers.add(marker2);
//     });
//     _animeteToUser(lat, lon);
//   }


// }
