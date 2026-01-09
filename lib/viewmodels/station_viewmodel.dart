import 'package:flutter/material.dart';
import '../models/station.dart';
import '../repositories/station_repository.dart';

enum StationViewState { loading, loaded, error }

class StationViewModel extends ChangeNotifier {
  final StationRepository _repository;

  StationViewModel({StationRepository? repository})
    : _repository = repository ?? StationRepository();

  StationViewState _state = StationViewState.loading;
  List<Station> _stations = [];
  String _errorMessage = '';
  Station? _selectedStation;

  StationViewState get state => _state;
  List<Station> get stations => _stations;
  String get errorMessage => _errorMessage;
  Station? get selectedStation => _selectedStation;

  Future<void> loadStations() async {
    _state = StationViewState.loading;
    _errorMessage = '';
    notifyListeners();

    try {
      _stations = await _repository.getStations();
      _state = StationViewState.loaded;
    } catch (e) {
      _state = StationViewState.error;
      _errorMessage = _getErrorMessage(e);
    }
    notifyListeners();
  }

  Future<void> refreshStations() async {
    await loadStations();
  }

  void selectStation(Station station) {
    _selectedStation = station;
    notifyListeners();
  }

  void clearSelection() {
    _selectedStation = null;
    notifyListeners();
  }

  String _getErrorMessage(dynamic error) {
    if (error.toString().contains('SocketException') ||
        error.toString().contains('conexión')) {
      return 'No se pudo conectar con el servidor.\nVerifica tu conexión a internet.';
    } else if (error.toString().contains('TimeoutException')) {
      return 'La solicitud ha tardado demasiado.\nIntenta nuevamente.';
    } else if (error.toString().contains('FormatException')) {
      return 'Error al procesar los datos.\nIntenta nuevamente más tarde.';
    } else {
      return 'Ha ocurrido un error.\nPor favor, intenta nuevamente.';
    }
  }
}
