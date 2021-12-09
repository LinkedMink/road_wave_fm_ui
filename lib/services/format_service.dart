import 'dart:convert';

import 'package:http/http.dart' as http;
import '/constants/http.dart';
import '/data/environment_config.dart';
import '/data/format.dart';

class FormatService {
  static const String _formatPath = 'formats';
  final String _apiBaseUrl = EnvironmentConfig.instance.roadWaveFmApiBaseUrl;

  Future<List<Format>> getAll() async {
    final response = await http.get(
        Uri.parse(_apiBaseUrl + FormatService._formatPath),
        headers: defaultHeaders);

    if (response.statusCode != 200) {
      throw Exception('Failed to retrieve formats');
    }

    final data = jsonDecode(response.body)['data'] as List<dynamic>;
    return data.map((d) => Format.fromJson(d)).toList(growable: false);
  }
}
