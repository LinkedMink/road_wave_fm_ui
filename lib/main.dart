import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:road_wave_fm_ui/app.dart';
import 'package:road_wave_fm_ui/constants/environments.dart';
import 'package:road_wave_fm_ui/data/environment_config.dart';

void main() {
  if (bool.hasEnvironment(envVarNames[EnvVar.environmentId]!)) {
    final envId = Environment.values.firstWhere(
        (e) =>
            describeEnum(e) ==
            String.fromEnvironment(envVarNames[EnvVar.environmentId]!),
        orElse: () => Environment.dev);

    EnvironmentConfig.init(envId);
  }

  runApp(const RoadWaveFmApp());
}
