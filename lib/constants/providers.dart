import 'package:package_info_plus/package_info_plus.dart';
import 'package:provider/provider.dart';

import '/models/format_list_model.dart';
import '/models/geolocation_model.dart';
import '/models/progress_model.dart';
import '/models/serach_location_model.dart';
import '/models/station_list_model.dart';
import '/services/format_service.dart';
import '/services/station_service.dart';

final appProviders = [
  FutureProvider<PackageInfo>(
      initialData: PackageInfo(
          appName: '', packageName: '', version: '', buildNumber: ''),
      create: (context) => PackageInfo.fromPlatform()),
  ChangeNotifierProvider<FormatListModel>(
    create: (context) {
      final model = FormatListModel(FormatService());
      model.fetchFormats();
      return model;
    },
  ),
  ChangeNotifierProvider<StationListModel>(
    create: (context) => StationListModel(StationService()),
  ),
  ChangeNotifierProxyProvider2<FormatListModel, StationListModel,
      ProgressModel>(
    create: (context) => ProgressModel(),
    update: (context, formatList, stationList, progress) {
      if (progress == null) {
        throw ArgumentError.notNull('progress');
      }
      return progress;
    },
  ),
  ChangeNotifierProvider<GeolocationModel>(create: (context) {
    final model = GeolocationModel();
    model.initialize();
    return model;
  }),
  ChangeNotifierProxyProvider3<FormatListModel, StationListModel,
      GeolocationModel, SearchLocationModel>(
    create: (context) => SearchLocationModel(),
    update: (context, formatList, stationList, geolocation, searchLocation) {
      if (searchLocation == null) {
        throw ArgumentError.notNull('searchLocation');
      }

      searchLocation.formatListModel = formatList;
      searchLocation.stationListModel = stationList;

      searchLocation.listenGeolocationUpdate(geolocation);

      return searchLocation;
    },
  ),
];
