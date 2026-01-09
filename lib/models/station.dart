import 'station_info.dart';
import 'station_status.dart';

class Station {
  final StationInfo info;
  final StationStatus status;

  Station({required this.info, required this.status});

  String get id => info.stationId;
  String get name => info.name;
  String get address => info.address;
  int get capacity => info.capacity;
  int get availableBikes => status.numBikesAvailable;
  int get availableDocks => status.numDocksAvailable;
  int get disabledBikes => status.numBikesDisabled;
  int get disabledDocks => status.numDocksDisabled;
  int get mechanicalBikes => status.mechanicalBikes;
  int get electricBikes => status.electricBikes;
  DateTime get lastUpdate =>
      DateTime.fromMillisecondsSinceEpoch(status.lastReported * 1000);
}
