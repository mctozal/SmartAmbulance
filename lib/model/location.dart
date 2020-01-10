
class LocationHospital {
  final double latitude;
  final double longitude;
  final String id;
  final String name;


  LocationHospital(this.latitude,this.longitude,this.id,this.name);

  LocationHospital.fromMappedJson(Map<String, dynamic> json)
      : latitude = json['latitude'],
        longitude = json['longitude'],
        id = json['id'],
        name = json['name'];

  Map<String, dynamic> toJson() =>
    {
      'latitude': latitude,
      'longitude': longitude,
      'id': id,
      'name': name,
    };

    
}