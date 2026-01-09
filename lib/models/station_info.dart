class StationInfo {
  final String stationId;
  final String name;
  final String physicalConfiguration;
  final double lat;
  final double lon;
  final String address;
  final String postCode;
  final int capacity;
  final bool isChargingStation;

  StationInfo({
    required this.stationId,
    required this.name,
    required this.physicalConfiguration,
    required this.lat,
    required this.lon,
    required this.address,
    required this.postCode,
    required this.capacity,
    required this.isChargingStation,
  });

  factory StationInfo.fromJson(Map<String, dynamic> json) {
    return StationInfo(
      stationId: json['station_id'] as String,
      name: json['name'] as String,
      physicalConfiguration: json['physical_configuration'] as String? ?? '',
      lat: (json['lat'] as num).toDouble(),
      lon: (json['lon'] as num).toDouble(),
      address: json['address'] as String? ?? '',
      postCode: json['post_code'] as String? ?? '',
      capacity: json['capacity'] as int? ?? 0,
      isChargingStation: json['is_charging_station'] as bool? ?? false,
    );
  }
}
