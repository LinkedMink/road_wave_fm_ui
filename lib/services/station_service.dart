import 'dart:convert';

import 'package:http/http.dart' as http;
import '/constants/http.dart';
import '/data/environment_config.dart';
import '/data/station.dart';

class StationService {
  static const String _formatPath = 'formats';
  final String _apiBaseUrl = EnvironmentConfig.instance.roadWaveFmApiBaseUrl;

  Future<List<Station>> get(
      double lat, double lng, List<String> formats) async {
    final response = await http.get(
        Uri.parse(_apiBaseUrl + StationService._formatPath),
        headers: defaultHeaders);

    if (response.statusCode != 200) {
      throw Exception('Failed to retrieve formats');
    }

    final data = jsonDecode(response.body)['data'] as List<dynamic>;
    return data.map((d) => Station.fromJson(d)).toList(growable: false);
  }
}
