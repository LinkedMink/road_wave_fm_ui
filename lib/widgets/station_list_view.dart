import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:road_wave_fm_ui/models/station_list_model.dart';
import 'package:road_wave_fm_ui/widgets/station_card.dart';

class StationListView extends StatelessWidget {
  const StationListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var stationList = context.watch<StationListModel>();
    return ListView(
        children: stationList.stationModels
            .map((s) => StationCard(station: s))
            .toList(growable: false));
  }
}
