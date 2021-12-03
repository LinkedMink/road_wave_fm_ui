import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:geolocator/geolocator.dart';

enum GeolocationPrompt { none, enableLocationServices, allowAppPermission }

class GeolocationModel extends ChangeNotifier {
  static const int _updateThresholdMeters = 500;
  static const LocationAccuracy _locationAccuracy = LocationAccuracy.medium;

  StreamSubscription<Position>? _locationSubscription;
  Position? _currentLocation;

  bool get isTrackingLocation => _locationSubscription != null;

  Position? get currentLocation => _currentLocation;

  Future<GeolocationPrompt> enableTracking() async {
    var serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      // Location services are not enabled don't continue
      // accessing the position and request users of the
      // App to enable the location services.
      return GeolocationPrompt.enableLocationServices;
    }

    var permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        // Permissions are denied, next time you could try
        // requesting permissions again (this is also where
        // Android's shouldShowRequestPermissionRationale
        // returned true. According to Android guidelines
        // your App should show an explanatory UI now.
        return GeolocationPrompt.allowAppPermission;
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return GeolocationPrompt.allowAppPermission;
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    var stream = Geolocator.getPositionStream(
        desiredAccuracy: _locationAccuracy,
        distanceFilter: _updateThresholdMeters);
    _locationSubscription = stream.listen(_updateLocation);

    return GeolocationPrompt.none;
  }

  Future<void> disableTracking() async {
    await _locationSubscription?.cancel();
    _locationSubscription = null;
  }

  _updateLocation(Position location) {
    _currentLocation = location;
    notifyListeners();
  }
}