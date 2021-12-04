import 'package:flutter/material.dart';
import 'package:road_wave_fm_ui/models/station_model.dart';
import 'package:road_wave_fm_ui/widgets/app_bar_builder.dart';

class StationDetailScreen extends StatelessWidget {
  const StationDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final route = ModalRoute.of(context);
    if (route == null) {
      throw ArgumentError.notNull('ModalRoute');
    }

    final station = route.settings.arguments as StationModel;

    return Scaffold(
      appBar: buildAppBar(context, title: station.callSign),
      body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[Text(station.format)]),
    );
  }
}
