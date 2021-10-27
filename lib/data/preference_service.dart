import 'package:shared_preferences/shared_preferences.dart';

class PreferenceService {
  static const selectedFormatsKey = 'selectedFormats';
  static const isLocationEnabledKey = 'isLocationEnabled';

  Future<List<String>> getSelectedFormats() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getStringList(selectedFormatsKey) ?? [];
  }

  Future<bool> setSelectedFormats(List<String> data) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.setStringList(selectedFormatsKey, data);
  }

  Future<bool> getIsLocationEnabled() async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.getBool(isLocationEnabledKey) ?? false;
  }

  Future<bool> setIsLocationEnabled(bool data) async {
    SharedPreferences preferences = await SharedPreferences.getInstance();
    return preferences.setBool(isLocationEnabledKey, data);
  }
}
