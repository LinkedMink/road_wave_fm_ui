import 'package:flutter/foundation.dart';

import '/data/station.dart';

// ignore: must_be_immutable
class StationModel extends Station with ChangeNotifier {
  final int index;
  bool _isSelected = false;

  bool get isSelected => _isSelected;

  set isSelected(bool isSelected) {
    if (_isSelected != isSelected) {
      _isSelected = isSelected;
      notifyListeners();
    }
  }

  bool toggle() => isSelected = !isSelected;

  StationModel(this.index, station)
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
