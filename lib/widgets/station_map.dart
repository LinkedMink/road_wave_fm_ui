import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

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
  static const double _boundPadding = 20.0;

  // Center of US
  static const CameraPosition _defaultInitialPosition = CameraPosition(
    target: LatLng(37.0902, -95.7129),
    zoom: 3.0,
  );

  final Completer<GoogleMapController> _controller = Completer();

  @override
  Widget build(BuildContext context) {
    var cameraPosition = _defaultInitialPosition;

    final stationModels = context
        .select<StationListModel, List<StationModel>>((m) => m.stationModels);
    final markers = stationModels
        .map((m) => Marker(
            markerId: MarkerId(m.id),
            position: LatLng(m.location.lat, m.location.lng),
            infoWindow: InfoWindow(title: m.callSign, snippet: m.format)))
        .toSet();
    _fitMarkers(markers);

    return GoogleMap(
      mapType: MapType.normal,
      myLocationEnabled: context
          .select<GeolocationModel, bool>((model) => model.isTrackingLocation),
      initialCameraPosition: cameraPosition,
      markers: markers,
      onMapCreated: (GoogleMapController controller) {
        _controller.complete(controller);
      },
    );
  }

  Future<void> _fitMarkers(Set<Marker> markers) async {
    if (markers.isEmpty || !_controller.isCompleted) {
      return;
    }

    final GoogleMapController controller = await _controller.future;
    final p1 = markers.first.position;
    if (markers.length < 2) {
      controller.animateCamera(CameraUpdate.newLatLngZoom(p1, _focusZoomLevel));
    }

    final p2 = markers.elementAt(1).position;
    final initialBounds = _getBounds(p1, p2);

    final markerBounds = markers.skip(2).fold<LatLngBounds>(
        initialBounds,
        (previousValue, element) =>
            _expandBounds(previousValue, element.position));

    controller.animateCamera(
        CameraUpdate.newLatLngBounds(markerBounds, _boundPadding));
  }

  _getBounds(LatLng p1, LatLng p2) {
    double nLat, sLat, eLng, wLng;
    if (p1.latitude < p2.latitude) {
      nLat = p2.latitude;
      sLat = p1.latitude;
    } else {
      nLat = p1.latitude;
      sLat = p2.latitude;
    }

    if (p1.longitude < p2.longitude) {
      eLng = p2.longitude;
      wLng = p1.longitude;
    } else {
      eLng = p1.longitude;
      wLng = p2.longitude;
    }

    return LatLngBounds(
        southwest: LatLng(sLat, wLng), northeast: LatLng(nLat, eLng));
  }

  _expandBounds(LatLngBounds bounds, LatLng next) {
    return LatLngBounds(
        southwest: LatLng(
            bounds.southwest.latitude < next.latitude
                ? bounds.southwest.latitude
                : next.latitude,
            bounds.southwest.longitude < next.longitude
                ? bounds.southwest.longitude
                : next.longitude),
        northeast: LatLng(
            bounds.northeast.latitude > next.latitude
                ? bounds.northeast.latitude
                : next.latitude,
            bounds.northeast.longitude > next.longitude
                ? bounds.northeast.longitude
                : next.longitude));
  }
}
