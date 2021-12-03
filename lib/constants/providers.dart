import 'package:provider/provider.dart';
import 'package:road_wave_fm_ui/models/format_list_model.dart';
import 'package:road_wave_fm_ui/models/geolocation_model.dart';
import 'package:road_wave_fm_ui/models/serach_location_model.dart';
import 'package:road_wave_fm_ui/models/station_list_model.dart';
import 'package:road_wave_fm_ui/services/format_service.dart';
import 'package:road_wave_fm_ui/services/station_service.dart';

final appProviders = [
  Provider(create: (context) => FormatService()),
  Provider(create: (context) => StationService()),
  ChangeNotifierProxyProvider<FormatService, FormatListModel>(
    create: (context) => FormatListModel(),
    update: (context, formatService, formatListModel) {
      if (formatListModel == null) {
        throw ArgumentError.notNull('formatListModel');
      }

      formatListModel.formatService = formatService;
      return formatListModel;
    },
  ),
  ChangeNotifierProxyProvider<StationService, StationListModel>(
    create: (context) => StationListModel(),
    update: (context, stationService, stationListModel) {
      if (stationListModel == null) {
        throw ArgumentError.notNull('stationListModel');
      }

      stationListModel.stationService = stationService;
      return stationListModel;
    },
  ),
  ChangeNotifierProvider<GeolocationModel>(
      create: (context) => GeolocationModel()),
  ChangeNotifierProxyProvider3<FormatListModel, StationListModel,
      GeolocationModel, SearchLocationModel>(
    create: (context) => SearchLocationModel(),
    update: (context, formatListModel, stationListModel, geolocationModel,
        searchLocationModel) {
      if (searchLocationModel == null) {
        throw ArgumentError.notNull('searchLocationModel');
      }

      searchLocationModel.formatListModel = formatListModel;
      searchLocationModel.stationListModel = stationListModel;

      searchLocationModel.listenGeolocationUpdate(geolocationModel);

      return searchLocationModel;
    },
  ),
];
