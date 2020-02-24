import 'dart:convert';

class Patient {
  String name;
  double latitude;
  double longitude;
  String phone;
  String vertigo;
  String nausea;
  String address;
  
  Patient({
    this.name,
    this.latitude,
    this.longitude,
    this.phone,
    this.vertigo,
    this.nausea,
    this.address,
  });

  Patient copyWith({
    String name,
    double latitude,
    double longitude,
    String phone,
    String vertigo,
    String nausea,
    String address,
  }) {
    return Patient(
      name: name ?? this.name,
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      phone: phone ?? this.phone,
      vertigo: vertigo ?? this.vertigo,
      nausea: nausea ?? this.nausea,
      address: address ?? this.address,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'latitude': latitude,
      'longitude': longitude,
      'phone': phone,
      'vertigo': vertigo,
      'nausea': nausea,
      'address': address,
    };
  }

  static Patient fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return Patient(
      name: map['name'],
      latitude: map['latitude'],
      longitude: map['longitude'],
      phone: map['phone'],
      vertigo: map['vertigo'],
      nausea: map['nausea'],
      address: map['address'],
    );
  }

  String toJson() => json.encode(toMap());

  static Patient fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() {
    return 'Patient name: $name, latitude: $latitude, longitude: $longitude, phone: $phone, vertigo: $vertigo, nausea: $nausea, address: $address';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
  
    return o is Patient &&
      o.name == name &&
      o.latitude == latitude &&
      o.longitude == longitude &&
      o.phone == phone &&
      o.vertigo == vertigo &&
      o.nausea == nausea &&
      o.address == address;
  }

  @override
  int get hashCode {
    return name.hashCode ^
      latitude.hashCode ^
      longitude.hashCode ^
      phone.hashCode ^
      vertigo.hashCode ^
      nausea.hashCode ^
      address.hashCode;
  }
}
