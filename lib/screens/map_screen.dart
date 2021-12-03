import 'package:flutter/material.dart';
import 'package:road_wave_fm_ui/constants/screens.dart';
import 'package:road_wave_fm_ui/widgets/navigation_bar.dart';

class MapScreen extends StatelessWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Map'),
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: const <Widget>[Text('Map')]),
      bottomNavigationBar: const NavigationBar(selectedScreen: Screen.map),
    );
  }
}
