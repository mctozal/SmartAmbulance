import 'dart:convert';
import 'package:collection/collection.dart';

class DistanceMatrix {

  List destination_addresses;
  List origin_addresses;
  List rows;
  String status;
  String id;
  DistanceMatrix({
    this.destination_addresses,
    this.origin_addresses,
    this.rows,
    this.status,
    this.id,
  });


  DistanceMatrix copyWith({
    List destination_addresses,
    List origin_addresses,
    List rows,
    String status,
    String id,
  }) {
    return DistanceMatrix(
      destination_addresses: destination_addresses ?? this.destination_addresses,
      origin_addresses: origin_addresses ?? this.origin_addresses,
      rows: rows ?? this.rows,
      status: status ?? this.status,
      id: id ?? this.id,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'destination_addresses': List<dynamic>.from(destination_addresses.map((x) => x)),
      'origin_addresses': List<dynamic>.from(origin_addresses.map((x) => x)),
      'rows': List<dynamic>.from(rows.map((x) => x)),
      'status': status,
      'id': id,
    };
  }

  static DistanceMatrix fromMap(Map<String, dynamic> map) {
    if (map == null) return null;
  
    return DistanceMatrix(
      destination_addresses: List.from(map['destination_addresses']),
      origin_addresses: List.from(map['origin_addresses']),
      rows: List.from(map['rows']),
      status: map['status'],
      id: map['id'],
    );
  }

  String toJson() => json.encode(toMap());

  static DistanceMatrix fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() {
    return 'DistanceMatrix(destination_addresses: $destination_addresses, origin_addresses: $origin_addresses, rows: $rows, status: $status, id: $id)';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;
    final listEquals = const DeepCollectionEquality().equals;
  
    return o is DistanceMatrix &&
      listEquals(o.destination_addresses, destination_addresses) &&
      listEquals(o.origin_addresses, origin_addresses) &&
      listEquals(o.rows, rows) &&
      o.status == status &&
      o.id == id;
  }

  @override
  int get hashCode {
    return destination_addresses.hashCode ^
      origin_addresses.hashCode ^
      rows.hashCode ^
      status.hashCode ^
      id.hashCode;
  }
}
