import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

import '/app.dart';
import '/constants/environments.dart';
import '/data/environment_config.dart';

void main() {
  if (bool.hasEnvironment(EnvVar.ENVIRONMENT_ID.name)) {
    final envId = Environment.values.firstWhere(
        (e) =>
            describeEnum(e) ==
            String.fromEnvironment(EnvVar.ENVIRONMENT_ID.name),
        orElse: () => Environment.dev);

    EnvironmentConfig.init(envId);
  }

  runApp(const RoadWaveFmApp());
}
