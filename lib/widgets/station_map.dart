import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
// import '/data/coordinates.dart';
import '/models/geolocation_model.dart';
import '/models/station_list_model.dart';
import '/models/station_model.dart';

class StationMap extends StatefulWidget {
  const StationMap({Key? key}) : super(key: key);

  @override
  State<StationMap> createState() => StationMapState();
}

class StationMapState extends State<StationMap> {
  static const double _focusZoomLevel = 10.0;
  static const CameraPosition _defaultInitialPosition = CameraPosition(
    target: LatLng(37.0902, -95.7129),
    zoom: 3.0,
  );

  final Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    var cameraPosition = _defaultInitialPosition;

    final geolocation = context.watch<GeolocationModel>();
    final currentLocation = geolocation.currentLocation;
    if (currentLocation != null) {
      cameraPosition = CameraPosition(
        target: LatLng(currentLocation.latitude, currentLocation.longitude),
        zoom: _focusZoomLevel,
      );
    }

    final stationModels = context
        .select<StationListModel, List<StationModel>>((m) => m.stationModels);
    final markers = stationModels
        .map((m) => Marker(
            markerId: MarkerId(m.id),
            position: LatLng(m.location.lat, m.location.lng),
            infoWindow: InfoWindow(title: m.callSign, snippet: m.format)))
        .toSet();

    return GoogleMap(
      mapType: MapType.normal,
      myLocationEnabled: geolocation.isTrackingLocation,
      initialCameraPosition: cameraPosition,
      markers: markers,
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
      },
    );
  }

  // Future<void> _focusCoordinates(Coordinates pos) async {
  //   final GoogleMapController controller = await _controller.future;
  //   controller.animateCamera(CameraUpdate.newCameraPosition(
  //       CameraPosition(target: LatLng(pos.lat, pos.lng), zoom: 12)));
  // }
}
