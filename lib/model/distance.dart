class Distance {
  String destinationAddress;
  String originAddress;
  int distance;
  int duration;

  Distance(this.destinationAddress, this.originAddress, this.distance,
      this.duration);
  Distance.fromMappedJson(Map<String, dynamic> json)
      : destinationAddress = json['destinationAddress'],
        originAddress = json['originAddress'],
        distance = json['distance'],
        duration = json['duration'];

  Map<String, dynamic> toJson() => {
        'destinationAddress': destinationAddress,
        'originAddress': originAddress,
        'distance': distance,
        'duration': duration,
      };
}
