import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/models/expansion_model.dart';
import '/models/search_location_model.dart';
import '/models/station_list_model.dart';
import '/models/station_model.dart';
import '/widgets/station_list_tile.dart';

class StationListView extends StatelessWidget {
  // todo: Determine height dynamically
  static const double _listItemHeight = 59.0;
  final _controller = ScrollController();

  StationListView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final expandModel = context.watch<ExpansionModel>();
    final hasSearched =
        context.select<SearchLocationModel, bool>((m) => m.hasSearched);
    final selectedModel =
        context.select<StationListModel, StationModel?>((m) => m.selected);

    if (selectedModel != null &&
        _controller.hasClients &&
        !expandModel.isExpanded) {
      _controller.animateTo(selectedModel.index * _listItemHeight,
          duration: const Duration(milliseconds: 250), curve: Curves.easeIn);
    }

    final theme = Theme.of(context);
    double screenHeight = MediaQuery.of(context).size.height;
    double height = hasSearched
        ? expandModel.isExpanded
            ? screenHeight - 0.30 * screenHeight
            : 84
        : 32;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 250),
      decoration: BoxDecoration(
          color: theme.bottomAppBarColor,
          border: expandModel.isExpanded
              ? Border.fromBorderSide(
                  BorderSide(color: theme.primaryColorDark, width: 8.0))
              : null),
      height: height,
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
                  child: const StationListTile()),
              shrinkWrap: true,
              controller: _controller);
        },
        selector: (_context, list) => list.stationModels);
  }
}
