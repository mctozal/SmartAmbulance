import 'dart:convert';

class HospitalsInfo {
  double latitude;
  double longitude;
  String id;
  String name;
  String rating;
  String icon;
  String formatted_address;

  HospitalsInfo({
    this.latitude,
    this.longitude,
    this.id,
    this.name,
    this.rating,
    this.icon,
    this.formatted_address,
  });

  HospitalsInfo copyWith({
    double latitude,
    double longitude,
    String id,
    String name,
    String rating,
    String icon,
    String formatted_address,
  }) {
    return HospitalsInfo(
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      id: id ?? this.id,
      name: name ?? this.name,
      rating: rating ?? this.rating,
      icon: icon ?? this.icon,
      formatted_address: formatted_address ?? this.formatted_address,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'latitude': latitude,
      'longitude': longitude,
      'id': id,
      'name': name,
      'rating': rating,
      'icon': icon,
      'formatted_address': formatted_address,
    };
  }

  static HospitalsInfo fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return HospitalsInfo(
      latitude: map['latitude'],
      longitude: map['longitude'],
      id: map['id'],
      name: map['name'],
      rating: map['rating'],
      icon: map['icon'],
      formatted_address: map['formatted_address'],
    );
  }

  String toJson() => json.encode(toMap());

  static HospitalsInfo fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() {
    return 'HospitalsInfo latitude: $latitude, longitude: $longitude, id: $id, name: $name, rating: $rating, icon: $icon, formatted_address: $formatted_address';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is HospitalsInfo &&
        o.latitude == latitude &&
        o.longitude == longitude &&
        o.id == id &&
        o.name == name &&
        o.rating == rating &&
        o.icon == icon &&
        o.formatted_address == formatted_address;
  }

  @override
  int get hashCode {
    return latitude.hashCode ^
        longitude.hashCode ^
        id.hashCode ^
        name.hashCode ^
        rating.hashCode ^
        icon.hashCode ^
        formatted_address.hashCode;
  }
}
