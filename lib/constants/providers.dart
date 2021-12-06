import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';
import 'package:road_wave_fm_ui/models/format_list_model.dart';
import 'package:road_wave_fm_ui/models/geolocation_model.dart';
import 'package:road_wave_fm_ui/models/progress_model.dart';
import 'package:road_wave_fm_ui/models/serach_location_model.dart';
import 'package:road_wave_fm_ui/models/station_list_model.dart';
import 'package:road_wave_fm_ui/services/format_service.dart';
import 'package:road_wave_fm_ui/services/station_service.dart';

final appProviders = [
  FutureProvider<PackageInfo>(
      initialData: PackageInfo(
          appName: '', packageName: '', version: '', buildNumber: ''),
      create: (context) => PackageInfo.fromPlatform()),
  ChangeNotifierProvider<ProgressModel>(create: (context) => ProgressModel()),
  ChangeNotifierProxyProvider<ProgressModel, FormatListModel>(
    create: (context) => FormatListModel(FormatService()),
    update: (context, progressModel, formatListModel) {
      if (formatListModel == null) {
        throw ArgumentError.notNull('formatListModel');
      }

      formatListModel.progressModel = progressModel;
      formatListModel.fetchFormats();
      return formatListModel;
    },
  ),
  ChangeNotifierProxyProvider<ProgressModel, StationListModel>(
    create: (context) => StationListModel(StationService()),
    update: (context, progressModel, stationListModel) {
      if (stationListModel == null) {
        throw ArgumentError.notNull('stationListModel');
      }

      stationListModel.progressModel = progressModel;
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
