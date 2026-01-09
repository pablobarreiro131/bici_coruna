import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/station_info.dart';
import '../models/station_status.dart';

class ApiService {
  static const String _baseUrl =
      'https://acoruna.publicbikesystem.net/customer/gbfs/v2/gl';
  static const String _stationInfoUrl = '$_baseUrl/station_information';
  static const String _stationStatusUrl = '$_baseUrl/station_status';

  Future<List<StationInfo>> getStationInformation() async {
    try {
      final response = await http.get(Uri.parse(_stationInfoUrl));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final stations = jsonData['data']['stations'] as List;

        return stations
            .map(
              (station) =>
                  StationInfo.fromJson(station as Map<String, dynamic>),
            )
            .toList();
      } else {
        throw Exception(
          'Error al cargar información de estaciones: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Error de conexión: $e');
    }
  }

  Future<List<StationStatus>> getStationStatus() async {
    try {
      final response = await http.get(Uri.parse(_stationStatusUrl));

      if (response.statusCode == 200) {
        final jsonData = json.decode(response.body);
        final stations = jsonData['data']['stations'] as List;

        return stations
            .map(
              (station) =>
                  StationStatus.fromJson(station as Map<String, dynamic>),
            )
            .toList();
      } else {
        throw Exception(
          'Error al cargar estado de estaciones: ${response.statusCode}',
        );
      }
    } catch (e) {
      throw Exception('Error de conexión: $e');
    }
  }
}
