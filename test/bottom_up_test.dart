import 'package:flutter_test/flutter_test.dart';
import 'package:bici_coruna/models/station_info.dart';
import 'package:bici_coruna/models/station_status.dart';
import 'package:bici_coruna/repositories/station_repository.dart';
import 'package:bici_coruna/viewmodels/station_viewmodel.dart';
import 'package:bici_coruna/services/api_service.dart';

class FakeApiService extends ApiService {
  @override
  Future<List<StationInfo>> getStationInformation() async {
    return [
      StationInfo.fromJson({
        "station_id": "1",
        "name": "Marina",
        "lat": 43.3623,
        "lon": -8.4115,
        "capacity": 20,
      }),
      StationInfo.fromJson({
        "station_id": "2",
        "name": "Obelisco",
        "lat": 43.3700,
        "lon": -8.4000,
        "capacity": 15,
      })
    ];
  }

  @override
  Future<List<StationStatus>> getStationStatus() async {
    return [
      StationStatus.fromJson({
        "station_id": "1",
        "num_bikes_available": 8,
        "num_docks_available": 12,
        "vehicle_types_available": [
          {"vehicle_type_id": "FIT", "count": 5},
          {"vehicle_type_id": "EFIT", "count": 3}
        ]
      }),
      StationStatus.fromJson({
        "station_id": "2",
        "num_bikes_available": 3,
        "num_docks_available": 12,
        "vehicle_types_available": [
          {"vehicle_type_id": "FIT", "count": 3}
        ]
      })
    ];
  }
}

void main() {
  group('Integración Ascendente', () {
    test('Flujo completo de JSON a UI', () async {
      final info = StationInfo.fromJson({
        "station_id": "1",
        "name": "Marina",
        "lat": 43.3623,
        "lon": -8.4115,
        "capacity": 20,
      });
      expect(info.stationId, '1');
      expect(info.name, 'Marina');

      final status = StationStatus.fromJson({
        "station_id": "1",
        "num_bikes_available": 8,
        "vehicle_types_available": [
          {"vehicle_type_id": "FIT", "count": 5},
          {"vehicle_type_id": "EFIT", "count": 3}
        ]
      });
      expect(status.mechanicalBikes, 5);
      expect(status.electricBikes, 3);

      final fakeApi = FakeApiService();
      final repository = StationRepository(apiService: fakeApi);
      final stations = await repository.getStations();
      
      expect(stations.length, 2);
      expect(stations[0].name, 'Marina');
      expect(stations[0].availableBikes, 8);
      expect(stations[1].name, 'Obelisco');

      final viewModel = StationViewModel(repository: repository);
      await viewModel.loadStations();

      expect(viewModel.state, StationViewState.loaded);
      expect(viewModel.stations.length, 2);
      expect(viewModel.stations[0].name, 'Marina');
      expect(viewModel.stations[0].mechanicalBikes, 5);
      expect(viewModel.stations[0].electricBikes, 3);
    });
  });
}