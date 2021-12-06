import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:road_wave_fm_ui/constants/screens.dart';
import 'package:road_wave_fm_ui/models/geolocation_model.dart';
import 'package:road_wave_fm_ui/models/progress_model.dart';
import 'package:road_wave_fm_ui/screens/action_screen.dart';
import 'package:road_wave_fm_ui/widgets/app_bar_builder.dart';
import 'package:road_wave_fm_ui/widgets/station_list_view.dart';
import 'package:road_wave_fm_ui/widgets/station_map.dart';

class SearchScreen extends StatelessWidget implements ActionScreen {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: buildAppBar(context),
        body: Stack(
          children: [_buildProgressBar(), const StationMap()],
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
