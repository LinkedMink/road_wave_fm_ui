import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:road_wave_fm_ui/models/format.dart';

class FormatService {
  static const String _formatPath = 'formats';
  final String _apiBaseUrl;

  const FormatService(this._apiBaseUrl);

  Future<List<Format>> getAll() async {
    var response = await http.get(Uri.parse(_apiBaseUrl + FormatService._formatPath));
    if (response.statusCode != 200) {
      throw Exception('Failed to retrieve formats');
    }

    var data = jsonDecode(response.body) as List<Map<String, dynamic>>;
    return data.map((d) => Format.fromJson(d)).toList();
  }
}
