class LocationHospital {
  final double lat;
  final double lng;


  LocationHospital(this.lat,this.lng);

  LocationHospital.fromMappedJson(Map<String, dynamic> json)
      : lat = json['lat'],
        lng = json['lng'];

  Map<String, dynamic> toJson() =>
    {
      'lat': lat,
      'lng': lng,
    };
}