import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:road_wave_fm_ui/models/station_list_model.dart';
import 'package:road_wave_fm_ui/widgets/station_card.dart';

class StationListView extends StatelessWidget {
  const StationListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final stationList = context.watch<StationListModel>();
    final cards = stationList.stationModels
        .map((s) =>
            ChangeNotifierProvider.value(value: s, child: const StationCard()))
        .toList(growable: false);

    return ListView(children: cards, shrinkWrap: true);
  }
}
