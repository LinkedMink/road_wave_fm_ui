import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '/constants/screens.dart';
import '/models/expansion_model.dart';
import '/models/geolocation_model.dart';
import '/models/progress_model.dart';
import '/models/search_location_model.dart';
import '/screens/action_screen.dart';
import '/widgets/app_bar_builder.dart';
import '/widgets/search_autocomplete.dart';
import '/widgets/station_list_view.dart';
import '/widgets/station_map.dart';

class SearchScreen extends StatelessWidget implements ActionScreen {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final searchModel = context.watch<SearchLocationModel>();

    return ChangeNotifierProvider.value(
        value: ExpansionModel(),
        child: Scaffold(
            appBar: buildAppBar(context),
            body: Column(children: [
              AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  child: Flexible(
                      child: Stack(
                    children: [
                      _buildProgressBar(),
                      const StationMap(),
                      const Positioned(
                          top: 24.0,
                          left: 16.0,
                          right: 16.0,
                          child: SearchAutocomplete())
                    ],
                  ))),
              AnimatedContainer(
                height: searchModel.hasSearched ? 96 : 40,
                duration: const Duration(milliseconds: 200),
                decoration: BoxDecoration(
                  color: theme.primaryColor,
                ),
              ),
            ]),
            bottomSheet: StationListView(),
            floatingActionButton:
                searchModel.hasSearched ? _buildExpandButton() : null));
  }

  @override
  List<Widget> buildActionButtons(BuildContext context) {
    return [
      IconButton(
          icon: const Icon(Icons.filter_alt),
          onPressed: () {
            Navigator.pushNamed(context, screenRoutes[Screen.filter]!.name);
          }),
      Consumer<GeolocationModel>(
          builder: (context, geolocation, child) => IconButton(
              icon: Icon(geolocation.isTrackingLocation
                  ? Icons.location_on
                  : Icons.location_off),
              onPressed: () {
                if (geolocation.isTrackingLocation) {
                  geolocation.disableTracking();
                } else {
                  geolocation.enableTracking();
                }
              })),
    ];
  }

  _buildExpandButton() => Consumer<ExpansionModel>(
      builder: (context, model, child) => FloatingActionButton(
          onPressed: () => model.toggle(),
          backgroundColor: Colors.blueGrey,
          child:
              Icon(model.isExpanded ? Icons.expand_more : Icons.expand_less)));

  _buildProgressBar() => Consumer<ProgressModel>(
      builder: (context, progressModel, child) => progressModel.isLoading
          ? LinearProgressIndicator(value: progressModel.proportionComplete)
          : const SizedBox(width: 0, height: 0));
}
