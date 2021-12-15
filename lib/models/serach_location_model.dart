import 'package:flutter/foundation.dart';

import '/data/search_query.dart';
import '/models/format_list_model.dart';
import '/models/geolocation_model.dart';
import '/models/station_list_model.dart';

class SearchLocationModel extends ChangeNotifier {
  SearchQuery? _currentQuery;

  late FormatListModel formatListModel;
  late StationListModel stationListModel;

  SearchQuery? get currentQuery => _currentQuery;

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
    await stationListModel.fetchStations(query);
    _currentQuery = query;
    notifyListeners();
  }
}
