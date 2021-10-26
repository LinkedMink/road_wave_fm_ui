import 'package:flutter/material.dart';
import 'package:road_wave_fm_ui/screens/about_screen.dart';
import 'package:road_wave_fm_ui/screens/list_screen.dart';
import 'package:road_wave_fm_ui/screens/map_screen.dart';
import 'package:road_wave_fm_ui/screens/search_screen.dart';
import 'package:road_wave_fm_ui/style/theme.dart';

void main() {
  runApp(const RoadWaveFmApp());
}

class RoadWaveFmApp extends StatelessWidget {
  const RoadWaveFmApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Road Wave FM',
      theme: appTheme,
      initialRoute: '/',
      routes: {
        '/': (context) => const SearchScreen(),
        '/list': (context) => const ListScreen(),
        '/map': (context) => const MapScreen(),
        '/about': (context) => const AboutScreen(),
      },
    );
  }
}
