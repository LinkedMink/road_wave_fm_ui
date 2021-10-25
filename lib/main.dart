import 'package:flutter/material.dart';
import 'package:road_wave_fm_ui/screens/home_screen.dart';
import 'package:road_wave_fm_ui/style/theme.dart';

void main() {
  runApp(const RoadWaveFmApp());
}

class RoadWaveFmApp extends StatelessWidget {
  const RoadWaveFmApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Road Wave FM',
      theme: appTheme,
      home: const HomeScreen(title: 'Home'),
    );
  }
}
