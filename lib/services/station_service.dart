import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:road_wave_fm_ui/data/environment_config.dart';
import 'package:road_wave_fm_ui/data/station.dart';

class StationService {
  static const String _formatPath = 'formats';
  final String _apiBaseUrl = EnvironmentConfig.instance.roadWaveFmApiBaseUrl;

  Future<List<Station>> get(
      double lat, double lng, List<String> formats) async {
    var response =
        await http.get(Uri.parse(_apiBaseUrl + StationService._formatPath));

    if (response.statusCode != 200) {
      throw Exception('Failed to retrieve formats');
    }

    var data = jsonDecode(response.body) as List<Map<String, dynamic>>;
    return data.map((d) => Station.fromJson(d)).toList(growable: false);
  }
}
