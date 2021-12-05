import 'package:flutter/foundation.dart';
import 'package:road_wave_fm_ui/constants/environments.dart';

@immutable
class EnvironmentConfig {
  static EnvironmentConfig _config = EnvironmentConfig.get(Environment.dev);

  final Environment id;
  final String roadWaveFmApiBaseUrl;
  final String userApiBaseUrl;

  const EnvironmentConfig(
      this.id, this.roadWaveFmApiBaseUrl, this.userApiBaseUrl);

  static EnvironmentConfig get instance {
    return _config;
  }

  static EnvironmentConfig init(Environment id) {
    _config = EnvironmentConfig.get(id);
    return _config;
  }

  factory EnvironmentConfig.get(Environment id) {
    switch (id) {
      case Environment.local:
        return EnvironmentConfig(
            id, "http://localhost:8081/", "http://localhost:8080/");
      case Environment.dev:
        return EnvironmentConfig(id, "https://roadwavefm.api.linkedmink.space/",
            "https://user.api.linkedmink.space/");
      case Environment.prod:
        return EnvironmentConfig(id, "https://roadwavefm.api.roadwavefm.com/",
            "https://user.api.roadwavefm.com/");
    }
  }

  @override
  int get hashCode => id.hashCode;

  @override
  bool operator ==(Object other) =>
      other is EnvironmentConfig && other.id == id;
}
