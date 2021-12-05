import 'package:flutter/foundation.dart';
import 'package:road_wave_fm_ui/data/station.dart';

// ignore: must_be_immutable
class StationModel extends Station with ChangeNotifier {
  bool _isSelected = false;

  bool get isSelected => _isSelected;

  set isSelected(bool isSelected) {
    _isSelected = isSelected;
    notifyListeners();
  }

  StationModel(Station station)
      : super(
            station.id,
            station.callSign,
            station.protocol,
            station.frequency,
            station.format,
            station.location,
            station.distance,
            station.signalStrength);
}
