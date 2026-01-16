import 'package:flutter_test/flutter_test.dart';
import 'package:bici_coruna/models/station_info.dart';
import 'package:bici_coruna/models/station_status.dart';
import 'package:bici_coruna/repositories/station_repository.dart';
import 'package:bici_coruna/services/api_service.dart';

class FakeApiService extends ApiService {
  List<StationInfo>? infoToReturn;
  List<StationStatus>? statusToReturn;
  
  @override
  Future<List<StationInfo>> getStationInformation() async {
    return infoToReturn ?? [];
  }
  
  @override
  Future<List<StationStatus>> getStationStatus() async {
    return statusToReturn ?? [];
  }
}

void main() {
  final json = {
    "station_id": "123",
    "num_bikes_available": 5,
    "num_docks_available": 10,
    "num_bikes_disabled": 1,
    "num_docks_disabled": 0,
    "status": "ACTIVE",
    "last_reported": 1625247600,
    "is_installed": true,
    "is_renting": true,
    "is_returning": true,
    "vehicle_types_available": [
      {"vehicle_type_id": "FIT", "count": 3},
      {"vehicle_type_id": "EFIT", "count": 2}
    ]
  };

  final json_info = {
    "station_id": "123",
    "name": "Estación Central",
    "physical_configuration": "BIKE_STATION",
    "lat": 43.3623,
    "lon": -8.4115,
    "address": "Calle Falsa 123",
    "post_code": "15001",
    "capacity": 20,
    "is_charging_station": true,
  };

  group('Station Repositorio Tests', () {
    late StationRepository repository;
    late FakeApiService fakeApi;

    setUp(() {
      fakeApi = FakeApiService();
      repository = StationRepository(apiService: fakeApi);
    });

    test('getStations devuelve estación combinando info y status', () async {
      fakeApi.infoToReturn = [StationInfo.fromJson(json_info)];
      fakeApi.statusToReturn = [StationStatus.fromJson(json)];

      final result = await repository.getStations();

      expect(result.length, 1);
      expect(result[0].id, '123');
      expect(result[0].availableBikes, 5);
    });

    test('getStationById devuelve la estación correcta', () async {
      fakeApi.infoToReturn = [StationInfo.fromJson(json_info)];
      fakeApi.statusToReturn = [StationStatus.fromJson(json)];

      final result = await repository.getStationById('123');

      expect(result?.id, '123');
      expect(result?.name, 'Estación Central');
    });
  });
}