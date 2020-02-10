import 'package:haversine/haversine.dart';

class DistanceCalculator {
  double calculate(sourceLat, sourceLon, destLat, destLon) {
    final harvesine = new Haversine.fromDegrees(
        latitude1: sourceLat,
        longitude1: sourceLon,
        latitude2: destLat,
        longitude2: destLon);
    // meter = 422591.551
    // final int meter = distance(source, destination);
    return harvesine.distance();
  }
}
