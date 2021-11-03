import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:road_wave_fm_ui/models/format_list_model.dart';
import 'package:road_wave_fm_ui/screens/about_screen.dart';
import 'package:road_wave_fm_ui/screens/list_screen.dart';
import 'package:road_wave_fm_ui/screens/map_screen.dart';
import 'package:road_wave_fm_ui/screens/search_screen.dart';
import 'package:road_wave_fm_ui/services/format_service.dart';
import 'package:road_wave_fm_ui/services/station_service.dart';
import 'package:road_wave_fm_ui/style/theme.dart';

class RoadWaveFmApp extends StatelessWidget {
  const RoadWaveFmApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          Provider(create: (context) => FormatService()),
          Provider(create: (context) => StationService()),
          ChangeNotifierProxyProvider<FormatService, FormatListModel>(
            create: (context) => FormatListModel(),
            update: (context, service, model) {
              if (model == null) throw ArgumentError.notNull('model');
              model.formatService = service;
              return model;
            },
          ),
        ],
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
