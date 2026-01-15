import 'package:flutter_test/flutter_test.dart';
import 'package:bici_coruna/models/station.dart';
import 'package:bici_coruna/models/station_info.dart';
import 'package:bici_coruna/models/station_status.dart';
import 'package:bici_coruna/repositories/station_repository.dart';
import 'package:bici_coruna/services/api_service.dart';
import 'package:bici_coruna/viewmodels/station_viewmodel.dart';

// Fake ApiService para tests
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

  final json_status = {
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
      {"vehicle_type_id": "FIT", "count": 3}
    ]
  };

  group('StationViewModel Tests', () {
    late StationViewModel viewModel;
    late FakeApiService fakeApi;

    setUp(() {
      fakeApi = FakeApiService();
      final repository = StationRepository(apiService: fakeApi);
      viewModel = StationViewModel(repository: repository);
    });

    test('loadStations carga estaciones correctamente', () async {
      fakeApi.infoToReturn = [StationInfo.fromJson(json_info)];
      fakeApi.statusToReturn = [StationStatus.fromJson(json_status)];

      await viewModel.loadStations();

      expect(viewModel.state, StationViewState.loaded);
      expect(viewModel.stations.length, 1);
    });

    test('selectStation selecciona estación', () {
      final info = StationInfo.fromJson(json_info);
      final status = StationStatus.fromJson(json_status);
      final station = Station(info: info, status: status);

      viewModel.selectStation(station);

      expect(viewModel.selectedStation?.id, '123');
    });
  });
}