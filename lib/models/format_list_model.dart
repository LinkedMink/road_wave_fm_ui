import 'package:flutter/foundation.dart';
import 'package:road_wave_fm_ui/constants/preferences.dart';
import 'package:road_wave_fm_ui/models/format_model.dart';
import 'package:road_wave_fm_ui/services/format_service.dart';
import 'package:road_wave_fm_ui/data/format.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FormatListModel extends ChangeNotifier {
  late FormatService _formatService;
  late List<Format> _formats;
  late List<FormatModel> _formatModels;
  final Set<String> _selectedFormatIds = <String>{};

  FormatService get formatService => _formatService;

  set formatService(FormatService formatService) {
    _formatService = formatService;
    _loadFormats();
  }

  List<FormatModel> get formatModels => _formatModels;

  List<String> get selectedFormatIds => _selectedFormatIds.toList();

  _loadFormats() async {
    var preferences = await SharedPreferences.getInstance();
    var formats =
        preferences.get(describeEnum(Preference.formats)) as List<Format>?;

    if (formats != null) {
      _formats = formats;

      var selectedFormatIds =
          preferences.getStringList(describeEnum(Preference.selectedFormatIds));
      if (selectedFormatIds != null) {
        _selectedFormatIds.addAll(selectedFormatIds);
      }

      _buildFormatModels();
      return;
    }

    _formats = await formatService.getAll();

    _buildFormatModels();
  }

  _buildFormatModels() {
    _formatModels = _formats
        .map((f) => FormatModel(f, _selectedFormatIds.contains(f.id)))
        .toList();
    _formatModels.forEach(_listenFormatModel);
    notifyListeners();
  }

  _listenFormatModel(FormatModel model) {
    model.addListener(() {
      if (model.isSelected) {
        _selectedFormatIds.add(model.id);
      } else {
        _selectedFormatIds.remove(model.id);
      }
    });
  }
}
