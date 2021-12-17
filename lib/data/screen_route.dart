import 'package:flutter/material.dart';

@immutable
class ScreenRoute {
  final String name;
  final WidgetBuilder factory;

  const ScreenRoute(this.name, this.factory);

  @override
  int get hashCode => name.hashCode;

  @override
  bool operator ==(Object other) => other is ScreenRoute && other.name == name;
}
