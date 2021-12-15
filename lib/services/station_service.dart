import 'dart:convert';

import 'package:http/http.dart' as http;

import '/constants/http.dart';
import '/data/environment_config.dart';
import '/data/search_query.dart';
import '/data/station.dart';

class StationService {
  static const String _apiPath = 'stations';
  final Uri _apiResourceUrl = Uri.parse(
      EnvironmentConfig.instance.roadWaveFmApiBaseUrl +
          StationService._apiPath);

  Future<List<Station>> get(SearchQuery query) async {
    final uri = _apiResourceUrl.replace(queryParameters: query.toQueryParams());

    final response = await http.get(uri, headers: defaultHeaders);

    if (response.statusCode != 200) {
      throw Exception('Failed to retrieve: $uri');
    }

    final data = jsonDecode(response.body)['data'] as List<dynamic>;
    return data.map((d) => Station.fromJson(d)).toList(growable: false);
  }
}
