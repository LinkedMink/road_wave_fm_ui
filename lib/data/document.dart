import 'package:flutter/foundation.dart';

@immutable
class Document {
  final String id;

  const Document(this.id);

  @override
  int get hashCode => id.hashCode;

  @override
  bool operator ==(Object other) => other is Document && other.id == id;
}
