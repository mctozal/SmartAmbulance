import 'dart:math';

import 'package:google_maps_flutter/google_maps_flutter.dart';

class ConvertToLatLng {
  List<LatLng> convertToLatLng(List points) {
    List<LatLng> result = <LatLng>[];
    for (int i = 0; i < points.length; i++) {
      if (i % 2 != 0) {
        result.add(LatLng(points[i - 1], points[i]));
      }
    }
    return result;
  }

  int generateIds() {
    var rng = new Random();
    var randomInt;
    randomInt = rng.nextInt(100);
    print(rng.nextInt(100));
    return randomInt;
  }
}
