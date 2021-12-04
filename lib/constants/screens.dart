import 'package:road_wave_fm_ui/data/screen_route.dart';
import 'package:road_wave_fm_ui/screens/about_screen.dart';
import 'package:road_wave_fm_ui/screens/filter_screen.dart';
import 'package:road_wave_fm_ui/screens/list_screen.dart';
import 'package:road_wave_fm_ui/screens/search_screen.dart';
import 'package:road_wave_fm_ui/screens/station_detail_screen.dart';

enum Screen { search, list, filter, details, about }

final screenRoutes = {
  Screen.search: ScreenRoute('/', (context) => const SearchScreen()),
  Screen.filter: ScreenRoute('/filter', (context) => const FilterScreen()),
  Screen.list: ScreenRoute('/list', (context) => const ListScreen()),
  Screen.details:
      ScreenRoute('/details', (context) => const StationDetailScreen()),
  Screen.about: ScreenRoute('/about', (context) => const AboutScreen()),
};

enum AppBarMenuOption { about }

final appBarMenuOptionScreen = {
  AppBarMenuOption.about: screenRoutes[Screen.about]!.name
};
