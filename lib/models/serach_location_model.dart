import 'package:flutter/foundation.dart';
import 'package:road_wave_fm_ui/data/search_query.dart';
import 'package:road_wave_fm_ui/models/format_list_model.dart';
import 'package:road_wave_fm_ui/models/geolocation_model.dart';
import 'package:road_wave_fm_ui/models/station_list_model.dart';

class SearchLocationModel extends ChangeNotifier {
  SearchQuery? _currentQuery;

  late FormatListModel formatListModel;
  late StationListModel stationListModel;

  listenGeolocationUpdate(GeolocationModel model) {
    model.addListener(() {
      final position = model.currentLocation;
      if (position == null) {
        return;
      }

      final query = SearchQuery(position.latitude, position.longitude,
          formatListModel.selectedFormatIds);

      if (query != _currentQuery) {
        search(query);
      }
    });
  }

  Future<void> search(SearchQuery query) async {
    await stationListModel.fetchStations(query.lat, query.lng, query.formatIds);
    _currentQuery = query;
  }
}
