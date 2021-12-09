import 'package:flutter/foundation.dart';
import '/data/document.dart';

@immutable
class Format extends Document {
  final String name;

  const Format(String id, this.name) : super(id);

  factory Format.fromJson(Map<String, dynamic> json) =>
      Format(json['id'], json['name']);
}
