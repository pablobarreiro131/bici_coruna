import 'package:flutter_test/flutter_test.dart';
import 'package:bici_coruna/models/station_status.dart';

void main() {

  final json = {
        "station_id": "123",
        "num_bikes_available": 5,
        "num_docks_available": 10,
        "num_bikes_disabled": 1,
        "num_docks_disabled": 0,
        "last_reported": 1625247600,
        "is_installed": true,
        "is_renting": true,
        "is_returning": true,
        "vehicle_types_available": [
          {"vehicle_type_id": "FIT", "count": 3},
          {"vehicle_type_id": "EFIT", "count": 2}
        ]
      };
  group('StationStatus Modelo', () {
    test('Creacion de objeto station_status', () {

      final status = StationStatus.fromJson(json);
      expect(status.stationId, '123');
      expect(status.numBikesAvailable, 5);
      expect(status.numDocksAvailable, 10);
      expect(status.numBikesDisabled, 1);
      expect(status.numDocksDisabled, 0);
      expect(status.lastReported, 1625247600);
      expect(status.isInstalled, true);
      expect(status.isRenting, true);
      expect(status.isReturning, true);
      expect(status.vehicleTypesAvailable.length, 2);
      expect(status.vehicleTypesAvailable[0].vehicleTypeId, 'FIT');
      expect(status.vehicleTypesAvailable[0].count, 3);
      expect(status.vehicleTypesAvailable[1].vehicleTypeId, 'EFIT');
      expect(status.vehicleTypesAvailable[1].count, 2);
    });

    test('Prueba para los getters', () {

      final status = StationStatus.fromJson(json);
      expect(status.mechanicalBikes, 3);
      expect(status.electricBikes, 2);
    });
  });
}

