import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:road_wave_fm_ui/constants/screens.dart';
import 'package:road_wave_fm_ui/models/geolocation_model.dart';

AppBar buildAppBar(BuildContext context, {String title = 'Road Wave FM'}) {
  final geolocation = context.watch<GeolocationModel>();

  return AppBar(
    leading: Navigator.canPop(context)
        ? IconButton(
            icon: const Icon(Icons.arrow_back),
            tooltip: "Back",
            onPressed: () => {Navigator.pop(context)})
        : null,
    title: Text(title),
    actions: [
      IconButton(
          icon: const Icon(Icons.filter),
          onPressed: () {
            Navigator.pushNamed(context, screenRoutes[Screen.filter]!.name);
          }),
      IconButton(
          icon: Icon(geolocation.isTrackingLocation
              ? Icons.location_on
              : Icons.location_off),
          onPressed: () {
            if (geolocation.isTrackingLocation) {
              geolocation.disableTracking();
            } else {
              geolocation.enableTracking();
            }
          }),
      PopupMenuButton<AppBarMenuOption>(
          icon: const Icon(Icons.menu),
          tooltip: "Menu",
          onSelected: (AppBarMenuOption option) {
            Navigator.pushNamed(context, appBarMenuOptionScreen[option]!);
          },
          itemBuilder: (BuildContext context) =>
              <PopupMenuEntry<AppBarMenuOption>>[
                const PopupMenuItem<AppBarMenuOption>(
                  value: AppBarMenuOption.about,
                  child: Text('About'),
                ),
              ])
    ],
  );
}
