import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/models/station_list_model.dart';
import '/models/station_model.dart';
import '/widgets/station_card.dart';

class StationListView extends StatelessWidget {
  const StationListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final stationModels = context
        .select<StationListModel, List<StationModel>>((m) => m.stationModels);
    final cards = stationModels
        .map((s) =>
            ChangeNotifierProvider.value(value: s, child: const StationCard()))
        .toList(growable: false);

    return ListView(children: cards, shrinkWrap: true);
  }
}
