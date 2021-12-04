import 'package:flutter/material.dart';
import 'package:road_wave_fm_ui/widgets/app_bar_builder.dart';
import 'package:road_wave_fm_ui/widgets/station_list_view.dart';

class ListScreen extends StatelessWidget {
  const ListScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(context),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: const <Widget>[Text('List'), StationListView()]),
    );
  }
}
