import 'package:flutter/foundation.dart';
import 'package:road_wave_fm_ui/data/station.dart';
import 'package:road_wave_fm_ui/models/format_list_model.dart';
import 'package:road_wave_fm_ui/models/station_model.dart';
import 'package:road_wave_fm_ui/services/station_service.dart';

class StationListModel extends ChangeNotifier {
  late StationService stationService;
  late FormatListModel formatListModel;
  List<Station> _stations = [];
  List<StationModel> _stationModels = [];
  StationModel? _selected;

  List<StationModel> get stationModels => _stationModels;

  StationModel? get selected => _selected;

  Future<void> fetchStations(
      double lat, double lng, List<String> formatIds) async {
    _stations = await stationService.get(lat, lng, formatIds);

    _selected = null;
    _stationModels = _stations.map((s) => StationModel(s)).toList();
    _stationModels.forEach(_listenStationModel);

    notifyListeners();
  }

  _listenStationModel(StationModel model) {
    model.addListener(() {
      if (!model.isSelected) {
        return;
      }

      _selected?.isSelected = false;
      _selected = model;
    });
  }
}
