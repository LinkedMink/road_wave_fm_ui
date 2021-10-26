import 'package:flutter/cupertino.dart';
import 'package:road_wave_fm_ui/models/document.dart';

@immutable
class Format extends Document {
  final String name;

  const Format(String id, this.name)
    : super(id);

  factory Format.fromJson(Map<String, dynamic> json) => Format(
      json['id'],
      json['name']
  );
}
