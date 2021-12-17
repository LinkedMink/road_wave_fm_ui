import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/models/expansion_model.dart';
import '/models/station_list_model.dart';
import '/models/station_model.dart';
import '/widgets/station_card.dart';

class StationListView extends StatelessWidget {
  // todo: Determine height dynamically
  static const double _listItemHeight = 59.0;
  final _controller = ScrollController();

  StationListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final expandModel = context.watch<ExpansionModel>();
    final selectedModel =
        context.select<StationListModel, StationModel?>((m) => m.selected);

    if (selectedModel != null &&
        _controller.hasClients &&
        !expandModel.isExpanded) {
      _controller.animateTo(selectedModel.index * _listItemHeight,
          duration: const Duration(milliseconds: 250), curve: Curves.easeIn);
    }

    double height = MediaQuery.of(context).size.height;
    final theme = Theme.of(context);
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      decoration: BoxDecoration(color: theme.bottomAppBarColor),
      height: expandModel.isExpanded ? height - 0.30 * height : 84,
      //padding: EdgeInsets.symmetric(),
      //constraints: const BoxConstraints(minHeight: 120, maxHeight: 240),
      child: _buildListView(context),
    );
  }

  _buildListView(BuildContext context) {
    return Selector<StationListModel, Set<StationModel>>(
        builder: (_context, stationModels, _child) {
          return ListView.builder(
              itemCount: stationModels.length,
              itemBuilder: (context, index) => ChangeNotifierProvider.value(
                  value: stationModels.elementAt(index),
                  child: const StationCard()),
              shrinkWrap: true,
              controller: _controller);
        },
        selector: (_context, list) => list.stationModels);
  }
}
