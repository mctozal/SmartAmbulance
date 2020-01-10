
class Distance {
  String destinationAddress;
  String originAddress;
  String destinationId;
  int distance;
  int duration;

  Distance(this.destinationAddress, this.originAddress,this.destinationId, this.distance,
      this.duration);
  Distance.fromMappedJson(Map<String, dynamic> json)
      : destinationAddress = json['destinationAddress'],
        originAddress = json['originAddress'],
        destinationId = json['destinationId'],
        distance = json['distance'],
        duration = json['duration'];

  Map<String, dynamic> toJson() => {
        'destinationAddress': destinationAddress,
        'originAddress': originAddress,
        'destinationId': destinationId,
        'distance': distance,
        'duration': duration,
      };
}
