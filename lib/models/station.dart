import 'package:flutter/cupertino.dart';
import 'package:road_wave_fm_ui/models/coordinates.dart';
import 'package:road_wave_fm_ui/models/document.dart';

@immutable
class Station extends Document {
  final String name;
  final String callSign;
  final String protocol;
  final String frequency;
  final String format;
  final Coordinates location;
  final double? distance;
  final double? signalStrength;

  const Station(
      String id,
      this.name,
      this.callSign,
      this.protocol,
      this.frequency,
      this.format,
      this.location,
      this.distance,
      this.signalStrength)
      : super(id);

  factory Station.fromJson(Map<String, dynamic> json) => Station(
      json['id'],
      json['name'],
      json['callSign'],
      json['protocol'],
      json['frequency'],
      json['format'],
      Coordinates.fromJson(json['location']),
      json['distance'],
      json['signalStrength']
  );
}
