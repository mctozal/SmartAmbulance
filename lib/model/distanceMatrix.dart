import 'dart:convert';

class DistanceMatrix {
  List destination_addresses;
  List origin_addresses;
  List rows;
  String status;
  DistanceMatrix({
    this.destination_addresses,
    this.origin_addresses,
    this.rows,
    this.status,
  });

  DistanceMatrix copyWith({
    List destination_addresses,
    List origin_addresses,
    List rows,
    String status,
  }) {
    return DistanceMatrix(
      destination_addresses:
          destination_addresses ?? this.destination_addresses,
      origin_addresses: origin_addresses ?? this.origin_addresses,
      rows: rows ?? this.rows,
      status: status ?? this.status,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'destination_addresses': destination_addresses.asMap(),
      'origin_addresses': origin_addresses.asMap(),
      'rows': rows.asMap(),
      'status': status,
    };
  }

  static DistanceMatrix fromMap(Map<String, dynamic> map) {
    if (map == null) return null;

    return DistanceMatrix(
      destination_addresses: List.from(map['destination_addresses']),
      origin_addresses: List.from(map['origin_addresses']),
      rows: List.from(map['rows']),
      status: map['status'],
    );
  }

  String toJson() => json.encode(toMap());

  static DistanceMatrix fromJson(String source) => fromMap(json.decode(source));

  @override
  String toString() {
    return 'DistanceMatrix destination_addresses: $destination_addresses, origin_addresses: $origin_addresses, rows: $rows, status: $status';
  }

  @override
  bool operator ==(Object o) {
    if (identical(this, o)) return true;

    return o is DistanceMatrix &&
        o.destination_addresses == destination_addresses &&
        o.origin_addresses == origin_addresses &&
        o.rows == rows &&
        o.status == status;
  }

  @override
  int get hashCode {
    return destination_addresses.hashCode ^
        origin_addresses.hashCode ^
        rows.hashCode ^
        status.hashCode;
  }
}
