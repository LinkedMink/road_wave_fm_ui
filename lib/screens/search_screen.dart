import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '/constants/screens.dart';
import '/models/geolocation_model.dart';
import '/models/progress_model.dart';
import '/screens/action_screen.dart';
import '/widgets/app_bar_builder.dart';
import '/widgets/search_autocomplete.dart';
import '/widgets/station_list_view.dart';
import '/widgets/station_map.dart';

class SearchScreen extends StatelessWidget implements ActionScreen {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(context),
        body: Stack(
          children: [
            _buildProgressBar(),
            const StationMap(),
            const Positioned(
                top: 24.0, left: 16.0, right: 16.0, child: SearchAutocomplete())
          ],
        ),
        bottomSheet: const StationListView());
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

  _buildProgressBar() => Consumer<ProgressModel>(
      builder: (context, progressModel, child) => progressModel.isLoading
          ? LinearProgressIndicator(value: progressModel.proportionComplete)
          : const SizedBox(width: 0, height: 0));
}
