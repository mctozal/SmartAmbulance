import 'dart:convert';

class HospitalsInfo {
  double latitude;
  double longitude;
  String id;
  String name;
  String rating;
  String icon;
  String formatted_address;
  String surgeryRoom;
  String availableDoctors;
  String emergency;
  String phone;

  HospitalsInfo({
    this.latitude,
    this.longitude,
    this.id,
    this.name,
    this.rating,
    this.icon,
    this.formatted_address,
    this.surgeryRoom="Available",
    this.availableDoctors="Not Available",
    this.emergency="Available",
    this.phone='tel:(0212)5232288',
    
    
  });

  HospitalsInfo copyWith({
    double latitude,
    double longitude,
    String id,
    String name,
    String rating,
    String icon,
    String formatted_address,
    String surgeryRoom,
    String availableDoctors,
    String emergency,
    String phone,
  }) {
    return HospitalsInfo(
      latitude: latitude ?? this.latitude,
      longitude: longitude ?? this.longitude,
      id: id ?? this.id,
      name: name ?? this.name,
      rating: rating ?? this.rating,
      icon: icon ?? this.icon,
      formatted_address: formatted_address ?? this.formatted_address,
      surgeryRoom: surgeryRoom ?? this.surgeryRoom,
      availableDoctors: availableDoctors ?? this.availableDoctors,
      emergency:emergency ?? this.emergency,
      phone: phone ?? this.phone,

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
      'surgeryRoom':surgeryRoom,
      'availableDoctors':availableDoctors,
      'emergency':emergency,
      'phone':phone,


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
      surgeryRoom: map['surgeryRoom'],
      availableDoctors:map['availableDoctors'],
      emergency:map['emergency'],
      phone: map['phone'],

    );
  }

  String toJson() => json.encode(toMap());

  static HospitalsInfo fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() {
    return 'HospitalsInfo latitude: $latitude, longitude: $longitude, id: $id, name: $name, rating: $rating, icon: $icon, formatted_address: $formatted_address , surgeryRoom:$surgeryRoom , availableDoctors:$availableDoctors ,emergency:$emergency , phone:$phone ';
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
        o.formatted_address == formatted_address&&
        o.surgeryRoom == surgeryRoom &&
        o.availableDoctors == availableDoctors &&
        o.emergency == emergency &&
        o.phone == phone;
  }

  @override
  int get hashCode {
    return latitude.hashCode ^
        longitude.hashCode ^
        id.hashCode ^
        name.hashCode ^
        rating.hashCode ^
        icon.hashCode ^
        formatted_address.hashCode ^
        surgeryRoom.hashCode  ^
        availableDoctors.hashCode ^
        emergency.hashCode ^
        phone.hashCode; 
  }
}
