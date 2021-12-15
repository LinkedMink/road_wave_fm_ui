import 'package:road_wave_fm_ui/screens/license_screen.dart';

import '/data/screen_route.dart';
import '/screens/about_screen.dart';
import '/screens/filter_screen.dart';
import '/screens/list_screen.dart';
import '/screens/search_screen.dart';
import '/screens/station_detail_screen.dart';

enum Screen { search, list, filter, details, about, license }

final screenRoutes = {
  Screen.search: ScreenRoute('/', (context) => const SearchScreen()),
  Screen.filter: ScreenRoute('/filter', (context) => const FilterScreen()),
  Screen.list: ScreenRoute('/list', (context) => const ListScreen()),
  Screen.details:
      ScreenRoute('/details', (context) => const StationDetailScreen()),
  Screen.about: ScreenRoute('/about', (context) => const AboutScreen()),
  Screen.license: ScreenRoute('/license', (context) => const LicenseScreen()),
};

enum AppBarMenuOption { about, license }

final appBarMenuOptionScreen = {
  AppBarMenuOption.about: screenRoutes[Screen.about]!.name,
  AppBarMenuOption.license: screenRoutes[Screen.license]!.name
};
