import 'package:flutter/foundation.dart';

@immutable
class Coordinates {
  final double lat;
  final double lng;

  const Coordinates(this.lat, this.lng);

  factory Coordinates.fromJson(Map<String, dynamic> json) =>
      Coordinates(json['lat'], json['lng']);

  @override
  int get hashCode => lat.hashCode ^ lng.hashCode;

  @override
  bool operator ==(Object other) =>
      other is Coordinates && other.lat == lat && other.lng == lng;
}
