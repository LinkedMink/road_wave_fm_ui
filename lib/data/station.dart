import 'package:flutter/foundation.dart';
import '/data/coordinates.dart';
import '/data/document.dart';

@immutable
class Station extends Document {
  final String callSign;
  final String protocol;
  final String frequency;
  final String format;
  final Coordinates location;
  final double distance;
  final double signalStrength;

  const Station(String id, this.callSign, this.protocol, this.frequency,
      this.format, this.location, this.distance, this.signalStrength)
      : super(id);

  factory Station.fromJson(Map<String, dynamic> json) => Station(
      json['id'],
      json['callSign'],
      json['protocol'],
      json['frequency'],
      json['format'],
      Coordinates.fromJson(json['location']),
      json['distance'],
      json['signalStrength']);
}
