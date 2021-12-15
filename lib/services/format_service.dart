import 'dart:convert';

import 'package:http/http.dart' as http;

import '/constants/http.dart';
import '/data/environment_config.dart';
import '/data/format.dart';

class FormatService {
  static const String _apiPath = 'formats';
  final Uri _apiResourceUrl = Uri.parse(
      EnvironmentConfig.instance.roadWaveFmApiBaseUrl + FormatService._apiPath);

  Future<List<Format>> getAll() async {
    final response = await http.get(_apiResourceUrl, headers: defaultHeaders);

    if (response.statusCode != 200) {
      throw Exception('Failed to retrieve: $_apiResourceUrl');
    }

    final data = jsonDecode(response.body)['data'] as List<dynamic>;
    return data.map((d) => Format.fromJson(d)).toList(growable: false);
  }
}
