class VehicleType {
  final String vehicleTypeId;
  final int count;

  VehicleType({required this.vehicleTypeId, required this.count});

  factory VehicleType.fromJson(Map<String, dynamic> json) {
    return VehicleType(
      vehicleTypeId: json['vehicle_type_id'] as String,
      count: json['count'] as int,
    );
  }
}

class StationStatus {
  final String stationId;
  final int numBikesAvailable;
  final int numBikesDisabled;
  final String status;
  final int numDocksAvailable;
  final int numDocksDisabled;
  final int lastReported;
  final bool isInstalled;
  final bool isRenting;
  final bool isReturning;
  final List<VehicleType> vehicleTypesAvailable;

  StationStatus({
    required this.stationId,
    required this.numBikesAvailable,
    required this.numBikesDisabled,
    required this.status,
    required this.numDocksAvailable,
    required this.numDocksDisabled,
    required this.lastReported,
    required this.isInstalled,
    required this.isRenting,
    required this.isReturning,
    required this.vehicleTypesAvailable,
  });

  factory StationStatus.fromJson(Map<String, dynamic> json) {
    var vehicleTypesList =
        json['vehicle_types_available'] as List<dynamic>? ?? [];

    return StationStatus(
      stationId: json['station_id'] as String,
      numBikesAvailable: json['num_bikes_available'] as int? ?? 0,
      numBikesDisabled: json['num_bikes_disabled'] as int? ?? 0,
      status: json['status'] as String? ?? 'UNKNOWN',
      numDocksAvailable: json['num_docks_available'] as int? ?? 0,
      numDocksDisabled: json['num_docks_disabled'] as int? ?? 0,
      lastReported: json['last_reported'] as int? ?? 0,
      isInstalled: json['is_installed'] as bool? ?? false,
      isRenting: json['is_renting'] as bool? ?? false,
      isReturning: json['is_returning'] as bool? ?? false,
      vehicleTypesAvailable: vehicleTypesList
          .map((vt) => VehicleType.fromJson(vt as Map<String, dynamic>))
          .toList(),
    );
  }

  int get mechanicalBikes {
    return vehicleTypesAvailable
        .where((vt) => vt.vehicleTypeId == 'FIT')
        .fold(0, (sum, vt) => sum + vt.count);
  }

  int get electricBikes {
    return vehicleTypesAvailable
        .where((vt) => vt.vehicleTypeId == 'EFIT')
        .fold(0, (sum, vt) => sum + vt.count);
  }

  int get boostBikes {
    return vehicleTypesAvailable
        .where((vt) => vt.vehicleTypeId == 'BOOST')
        .fold(0, (sum, vt) => sum + vt.count);
  }
}
