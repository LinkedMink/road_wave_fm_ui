import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/models/expansion_model.dart';
import '/models/station_list_model.dart';
import '/models/station_model.dart';
import '/widgets/station_card.dart';

class StationListView extends StatelessWidget {
  const StationListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final expandModel = context.watch<ExpansionModel>();
    final stationModels = context
        .select<StationListModel, List<StationModel>>((m) => m.stationModels);
    final cards = stationModels
        .map((s) =>
            ChangeNotifierProvider.value(value: s, child: const StationCard()))
        .toList(growable: false);

    double height = MediaQuery.of(context).size.height;
    final theme = Theme.of(context);
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(color: theme.bottomAppBarColor),
      height: expandModel.isExpanded ? height - 0.30 * height : 84,
      //constraints: const BoxConstraints(minHeight: 120, maxHeight: 240),
      child: ListView(children: cards, shrinkWrap: true),
    );
  }
}
