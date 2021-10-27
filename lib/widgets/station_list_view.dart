import 'package:flutter/material.dart';
import 'package:road_wave_fm_ui/models/station.dart';
import 'package:road_wave_fm_ui/widgets/station_card.dart';

class StationListView extends StatelessWidget {
  final List<Station> stations;

  const StationListView({Key? key, required this.stations}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
        children: stations
            .map((s) => StationCard(station: s))
            .toList(growable: false));
  }
}
