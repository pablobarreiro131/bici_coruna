import 'package:flutter_test/flutter_test.dart';
import 'package:bici_coruna/models/station.dart';
import 'package:bici_coruna/models/station_info.dart';
import 'package:bici_coruna/models/station_status.dart';
import 'package:bici_coruna/repositories/station_repository.dart';
import 'package:bici_coruna/viewmodels/station_viewmodel.dart';

class FakeStationRepository extends StationRepository {
  bool shouldFail = false;
  List<Station>? stationsToReturn;

  @override
  Future<List<Station>> getStations() async {
    await Future.delayed(Duration(milliseconds: 100));

    if (shouldFail) {
      throw Exception('SocketException: No se pudo conectar');
    }

    return stationsToReturn ?? _getDefaultStations();
  }

  @override
  Future<Station?> getStationById(String id) async {
    final stations = await getStations();
    return stations.firstWhere((s) => s.id == id);
  }

  List<Station> _getDefaultStations() {
    return [
      Station(
        info: StationInfo.fromJson({
          "station_id": "100",
          "name": "Test Station",
          "lat": 43.0,
          "lon": -8.0,
          "capacity": 10,
        }),
        status: StationStatus.fromJson({
          "station_id": "100",
          "num_bikes_available": 5,
          "num_docks_available": 5,
          "vehicle_types_available": []
        })
      )
    ];
  }
}

void main() {
  group('Integración Descendente', () {
    late StationViewModel viewModel;
    late FakeStationRepository fakeRepository;

    setUp(() {
      fakeRepository = FakeStationRepository();
      viewModel = StationViewModel(repository: fakeRepository);
    });

    test('Comprobación del estado de carga del viewmodel.', () async {
      expect(viewModel.state, StationViewState.loading);

      final loadFuture = viewModel.loadStations();
      expect(viewModel.state, StationViewState.loading);
      await loadFuture;
      expect(viewModel.state, StationViewState.loaded);
      expect(viewModel.stations.length, 1);
      expect(viewModel.errorMessage, '');
    });

    test('Comprobación de la conexión en el viewmodel.', () async {
      fakeRepository.shouldFail = true;

      await viewModel.loadStations();

      expect(viewModel.state, StationViewState.error);
      expect(viewModel.errorMessage, contains('No se pudo conectar'));
      expect(viewModel.stations.isEmpty, true);
    });

    test('Comprobación de que el viewmodel puede refrescar tras error', () async {

      fakeRepository.shouldFail = true;
      await viewModel.loadStations();
      expect(viewModel.state, StationViewState.error);

      fakeRepository.shouldFail = false;
      await viewModel.refreshStations();

      expect(viewModel.state, StationViewState.loaded);
      expect(viewModel.stations.isNotEmpty, true);
    });

    test('Comprobación de que el viewmodel gestiona selección de estación', () async {
      await viewModel.loadStations();
      
      final station = viewModel.stations.first;
      viewModel.selectStation(station);

      expect(viewModel.selectedStation?.id, '100');
      expect(viewModel.selectedStation?.name, 'Test Station');

      viewModel.clearSelection();
      expect(viewModel.selectedStation, null);
    });
  });
}