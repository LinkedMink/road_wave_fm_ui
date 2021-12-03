import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:road_wave_fm_ui/constants/providers.dart';
import 'package:road_wave_fm_ui/constants/theme.dart';
import 'package:road_wave_fm_ui/screens/about_screen.dart';
import 'package:road_wave_fm_ui/screens/list_screen.dart';
import 'package:road_wave_fm_ui/screens/map_screen.dart';
import 'package:road_wave_fm_ui/screens/search_screen.dart';

class RoadWaveFmApp extends StatelessWidget {
  const RoadWaveFmApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: appProviders,
        child: MaterialApp(
          title: 'Road Wave FM',
          theme: appTheme,
          initialRoute: '/',
          routes: {
            '/': (context) => const SearchScreen(),
            '/list': (context) => const ListScreen(),
            '/map': (context) => const MapScreen(),
            '/about': (context) => const AboutScreen(),
          },
        ));
  }
}
