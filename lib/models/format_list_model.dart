import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '/constants/preferences.dart';
import '/data/format.dart';
import '/models/format_model.dart';
import '/models/loading_model.dart';
import '/services/format_service.dart';

class FormatListModel extends ChangeNotifier with LoadingModel {
  final FormatService _formatService;
  final Set<String> _selectedFormatIds = <String>{};
  List<Format> _formats = [];
  List<FormatModel> _formatModels = [];
  bool _hasModifiedSelected = false;

  List<String> get selectedFormatIds => _selectedFormatIds.toList();

  List<FormatModel> get formatModels => _formatModels;

  bool get hasModifiedSelected => _hasModifiedSelected;

  FormatListModel(this._formatService);

  Future<void> fetchFormats() => runLoadFunc(_fetchFormatsFunc);

  void clearSelectedFormats() {
    for (var m in _formatModels) {
      m.isSelected = false;
    }
  }

  Future<void> restoreSelectedFormats() async {
    await _loadSelectedFormatsFromPreferences();
    for (var m in _formatModels) {
      m.isSelected = _selectedFormatIds.contains(m.id);
    }
  }

  Future<bool> saveSelectedFormats() async {
    final preferences = await SharedPreferences.getInstance();
    final result = preferences.setStringList(
        Preference.selectedFormatIds.name, selectedFormatIds);
    _hasModifiedSelected = false;
    notifyListeners();
    return result;
  }

  Future<void> _fetchFormatsFunc() async {
    await Future.wait([_loadFormats(), _loadSelectedFormatsFromPreferences()]);
    _formatModels = _buildFormatModels(_formats, _selectedFormatIds);
  }

  Future<bool> _loadSelectedFormatsFromPreferences() async {
    _hasModifiedSelected = false;
    _selectedFormatIds.clear();

    final preferences = await SharedPreferences.getInstance();
    final selectedIds =
        preferences.getStringList(Preference.selectedFormatIds.name);
    if (selectedIds == null) {
      return false;
    }

    _selectedFormatIds.addAll(selectedIds);
    return true;
  }

  Future<void> _loadFormats() async {
    _formats = await _formatService.getAll();
  }

  _buildFormatModels(List<Format> formats, Set<String> selectedIds) {
    final models = _formats.map((f) {
      final model = FormatModel(f, selectedIds.contains(f.id));
      _listenFormatModel(model);
      return model;
    }).toList();
    models.sort((a, b) => a.name.compareTo(b.name));
    return models;
  }

  _listenFormatModel(FormatModel model) {
    model.addListener(() {
      bool shouldNotify = false;
      if (model.isSelected && !_selectedFormatIds.contains(model.id)) {
        if (_selectedFormatIds.isEmpty) {
          shouldNotify = true;
        }
        _selectedFormatIds.add(model.id);
      } else if (!model.isSelected && _selectedFormatIds.contains(model.id)) {
        _selectedFormatIds.remove(model.id);
        if (_selectedFormatIds.isEmpty) {
          shouldNotify = true;
        }
      } else {
        return;
      }

      if (!_hasModifiedSelected) {
        _hasModifiedSelected = true;
        shouldNotify = true;
      }

      if (shouldNotify) {
        notifyListeners();
      }
    });
  }
}
