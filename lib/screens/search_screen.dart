import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:road_wave_fm_ui/models/geolocation_model.dart';
import 'package:road_wave_fm_ui/widgets/app_bar_builder.dart';
import 'package:road_wave_fm_ui/widgets/format_grid_view.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final geolocation = context.watch<GeolocationModel>();

    return Scaffold(
      appBar: buildAppBar(context),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            TextFormField(
                decoration: const InputDecoration(
                  hintText: 'Search',
                ),
                readOnly: geolocation.isTrackingLocation),
            const FormatGridView(),
          ],
        ),
      ),
    );
  }
}
