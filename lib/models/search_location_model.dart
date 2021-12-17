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

  bool get hasSearched => _currentQuery != null;

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

  listenFormatUpdate(FormatListModel model) {
    model.addListener(() {
      final current = _currentQuery;
      if (current == null) {
        return;
      }

      final query =
          SearchQuery.fromQuery(current, formatListModel.selectedFormatIds);

      if (query != current) {
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
