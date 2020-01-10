class HospitalsInfo {
   double latitude;
   double longitude;
   String id;
   String name;


  HospitalsInfo(
    this.latitude,
    this.longitude,
    this.id,
    this.name 
  );

  Map<String, dynamic> toMap() {
    return {
      'latitude': latitude,
      'longitude': longitude,
      'id': id,
      'name': name,
    };
  }

}