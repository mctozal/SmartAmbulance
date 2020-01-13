import 'dart:convert';

class AmbulanceInfo {
  double latitude;
  double longitude;
  String id;
  String name;
  String ambulancePlate;
  String vehicleLicence;
  String vehicleLicenceDate;

  AmbulanceInfo({
    this.latitude,
    this.longitude,
    this.id,
     this.name,
    this.ambulancePlate,
    this.vehicleLicence,
    this.vehicleLicenceDate
  });

  AmbulanceInfo copyWith({
    double latitude,
    double longitude,
    String id,
     String name,
    String ambulancePlate,
    String vehicleLicence,
    String vehicleLicenceDate,
  }) {
    return AmbulanceInfo(
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      id: id ?? this.id,
      name: name ?? this.name,
      ambulancePlate: ambulancePlate ?? this.ambulancePlate,
      vehicleLicence: vehicleLicence ?? this.vehicleLicence,
      vehicleLicenceDate: vehicleLicenceDate ?? this.vehicleLicenceDate,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'latitude': latitude,
      'longitude': longitude,
      'id': id,
      'name': name,
      'ambulancePlate':ambulancePlate,
      'vehicleLicence':vehicleLicence,
      'vehicleLicenceDate':vehicleLicenceDate,
    };
  }

  static AmbulanceInfo fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return AmbulanceInfo(
      latitude: map['latitude'],
      longitude: map['longitude'],
      id: map['id'],
      name: map['name'],
      ambulancePlate: map['ambulancePlate'],
      vehicleLicence: map['vehicleLicence'],
      vehicleLicenceDate: map['vehicleLicenceDate'],
    );
  }

  String toJson() => json.encode(toMap());

  static AmbulanceInfo fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() {
    return 'AmbulanceInfo latitude: $latitude, longitude: $longitude, id: $id, name: $name, ambulancePlate:$ambulancePlate ,vehicleLicence:$vehicleLicence, vehicleLicenceDate:$vehicleLicenceDate';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is AmbulanceInfo &&
        o.latitude == latitude &&
        o.longitude == longitude &&
        o.id == id &&
        o.name == name &&
        o.ambulancePlate == ambulancePlate &&
        o.vehicleLicence == vehicleLicence &&
        o.vehicleLicenceDate == vehicleLicenceDate;
  }

  @override
  int get hashCode {
    return latitude.hashCode ^
        longitude.hashCode ^
        id.hashCode ^
        name.hashCode ^
        ambulancePlate.hashCode ^
        vehicleLicence.hashCode ^
        vehicleLicenceDate.hashCode;
  }
}
