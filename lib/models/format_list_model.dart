import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '/constants/preferences.dart';
import '/data/format.dart';
import '/models/format_model.dart';
import '/models/loading_model.dart';
import '/services/format_service.dart';

class FormatListModel extends ChangeNotifier with LoadingModel {
  final FormatService _formatService;
  List<Format> _formats = [];
  List<FormatModel> _formatModels = [];
  final Set<String> _selectedFormatIds = <String>{};

  List<FormatModel> get formatModels => _formatModels;

  List<String> get selectedFormatIds => _selectedFormatIds.toList();

  FormatListModel(this._formatService);

  Future<void> fetchFormats() async {
    isLoading = true;
    final preferences = await SharedPreferences.getInstance();
    final formats = preferences.get(Preference.formats.name) as List<Format>?;

    if (formats != null) {
      _formats = formats;

      final selectedFormatIds =
          preferences.getStringList(Preference.selectedFormatIds.name);
      if (selectedFormatIds != null) {
        _selectedFormatIds.addAll(selectedFormatIds);
      }

      _buildFormatModels();
      return;
    }

    _formats = await _formatService.getAll();

    _buildFormatModels();
  }

  Future<bool> saveSelectedFormats() async {
    final preferences = await SharedPreferences.getInstance();
    final result = preferences.setStringList(
        Preference.selectedFormatIds.name, selectedFormatIds);
    notifyListeners();
    return result;
  }

  _buildFormatModels() {
    _formatModels = _formats.map((f) {
      final model = FormatModel(f, _selectedFormatIds.contains(f.id));
      _listenFormatModel(model);
      return model;
    }).toList();
    _formatModels.sort((a, b) => a.name.compareTo(b.name));
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
