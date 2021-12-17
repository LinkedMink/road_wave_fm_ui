import 'package:flutter/foundation.dart';

import '/data/search_query.dart';
import '/data/station.dart';
import '/models/station_model.dart';
import '/services/station_service.dart';

class StationListModel extends ChangeNotifier {
  final StationService _stationService;
  final Set<StationModel> _stationModels = {};
  List<Station> _stations = [];
  StationModel? _selected;

  Set<StationModel> get stationModels => _stationModels;

  StationModel? get selected => _selected;

  StationListModel(this._stationService);

  Future<void> fetchStations(SearchQuery query) async {
    _stations = await _stationService.get(query);

    _selected = null;
    _stationModels.clear();
    _stations.asMap().forEach((index, station) {
      final model = StationModel(index, station);
      _stationModels.add(model);
      _listenStationModel(model);
    });

    notifyListeners();
  }

  _listenStationModel(StationModel model) {
    model.addListener(() {
      if (_selected == model) {
        if (!model.isSelected) {
          _selected = null;
        } else {
          return;
        }
      } else {
        _selected?.isSelected = false;
        _selected = model;
      }

      notifyListeners();
    });
  }
}
