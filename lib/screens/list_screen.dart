import 'package:flutter/material.dart';
import 'package:road_wave_fm_ui/constants/screens.dart';
import 'package:road_wave_fm_ui/widgets/navigation_bar.dart';
import 'package:road_wave_fm_ui/widgets/station_list_view.dart';

class ListScreen extends StatelessWidget {
  const ListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('List'),
      ),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: const <Widget>[Text('List'), StationListView()]),
      bottomNavigationBar: const NavigationBar(selectedScreen: Screen.list),
    );
  }
}
