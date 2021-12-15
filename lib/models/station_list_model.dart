import 'package:flutter/foundation.dart';

import '/data/search_query.dart';
import '/data/station.dart';
import '/models/station_model.dart';
import '/services/station_service.dart';

class StationListModel extends ChangeNotifier {
  final StationService _stationService;
  List<Station> _stations = [];
  List<StationModel> _stationModels = [];
  StationModel? _selected;

  List<StationModel> get stationModels => _stationModels;

  StationModel? get selected => _selected;

  StationListModel(this._stationService);

  Future<void> fetchStations(SearchQuery query) async {
    _stations = await _stationService.get(query);

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
      notifyListeners();
    });
  }
}
