import 'package:flutter/foundation.dart';

import '/data/search_query.dart';
import '/models/loading_model.dart';
import '/models/station_model.dart';
import '/services/station_service.dart';

class StationListModel extends ChangeNotifier with LoadingModel {
  final StationService _stationService;
  Set<StationModel> _stationModels = {};
  StationModel? _selected;

  Set<StationModel> get stationModels => _stationModels;

  StationModel? get selected => _selected;

  StationListModel(this._stationService);

  Future<void> fetchStations(SearchQuery query) =>
      runLoadFunc(_fetchStationsFunc(query));

  _fetchStationsFunc(SearchQuery query) {
    return () async {
      final stations = await _stationService.get(query);

      _selected = null;
      _stationModels = {};

      stations.asMap().forEach((index, station) {
        final model = StationModel(index, station);
        _stationModels.add(model);
        _listenStationModel(model);
      });
    };
  }

  _listenStationModel(StationModel model) {
    model.addListener(() {
      if (_selected == model && !model.isSelected) {
        _selected = null;
      } else if (_selected != model && model.isSelected) {
        _selected?.isSelected = false;
        _selected = model;
      } else {
        return;
      }

      notifyListeners();
    });
  }
}
