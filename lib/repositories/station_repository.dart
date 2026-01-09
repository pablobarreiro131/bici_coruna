import '../models/station.dart';
import '../models/station_info.dart';
import '../models/station_status.dart';
import '../services/api_service.dart';

class StationRepository {
  final ApiService _apiService;

  StationRepository({ApiService? apiService})
    : _apiService = apiService ?? ApiService();

  Future<List<Station>> getStations() async {
    try {
      final infoList = await _apiService.getStationInformation();
      final statusList = await _apiService.getStationStatus();

      final Map<String, StationInfo> infoMap = {
        for (var info in infoList) info.stationId: info,
      };

      final Map<String, StationStatus> statusMap = {
        for (var status in statusList) status.stationId: status,
      };

      final List<Station> stations = [];

      for (var stationId in infoMap.keys) {
        if (statusMap.containsKey(stationId)) {
          stations.add(
            Station(info: infoMap[stationId]!, status: statusMap[stationId]!),
          );
        }
      }

      stations.sort((a, b) => a.name.compareTo(b.name));

      return stations;
    } catch (e) {
      throw Exception('Error al obtener estaciones: $e');
    }
  }

  Future<Station?> getStationById(String stationId) async {
    try {
      final stations = await getStations();
      return stations.firstWhere(
        (station) => station.id == stationId,
        orElse: () => throw Exception('Estación no encontrada'),
      );
    } catch (e) {
      throw Exception('Error al obtener estación: $e');
    }
  }
}
