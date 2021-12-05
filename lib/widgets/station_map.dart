import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
// import 'package:road_wave_fm_ui/data/coordinates.dart';
import 'package:road_wave_fm_ui/models/geolocation_model.dart';
// import 'package:road_wave_fm_ui/models/station_list_model.dart';
import 'package:road_wave_fm_ui/models/station_model.dart';

class StationMap extends StatefulWidget {
  const StationMap({Key? key}) : super(key: key);

  @override
  State<StationMap> createState() => StationMapState();
}

class StationMapState extends State<StationMap> {
  final Completer<GoogleMapController> _controller = Completer();
  bool isTrackingPreviousVal = false;
  StationModel? selectedStation;

  static const CameraPosition _defaultInitialPosition = CameraPosition(
    target: LatLng(37.0902, -95.7129),
    zoom: 4.0,
  );

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    var cameraPosition = _defaultInitialPosition;

    final geolocation = context.watch<GeolocationModel>();
    final currentLocation = geolocation.currentLocation;
    if (currentLocation != null &&
        isTrackingPreviousVal != geolocation.isTrackingLocation) {
      cameraPosition = CameraPosition(
        target: LatLng(currentLocation.latitude, currentLocation.longitude),
        zoom: 10.0,
      );
      isTrackingPreviousVal = geolocation.isTrackingLocation;
    }

    // final stationList = context.watch<StationListModel>();
    // if (stationList.selected != null) {
    //   selectedStation = stationList.selected;
    //   _focusCoordinates(stationList.selected!.location);
    // }

    return Stack(
      children: [
        GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: cameraPosition,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
        ),
        Positioned(
            top: 24.0,
            left: 16.0,
            right: 16.0,
            child: TextFormField(
                decoration: InputDecoration(
                    suffixIcon: const Icon(Icons.search),
                    border: const UnderlineInputBorder(),
                    hintText: 'Search',
                    filled: true,
                    fillColor: theme.cardColor),
                autofocus: !geolocation.isTrackingLocation,
                readOnly: geolocation.isTrackingLocation))
      ],
    );
  }

  // Future<void> _focusCoordinates(Coordinates pos) async {
  //   final GoogleMapController controller = await _controller.future;
  //   controller.animateCamera(CameraUpdate.newCameraPosition(
  //       CameraPosition(target: LatLng(pos.lat, pos.lng), zoom: 12)));
  // }
}
