import 'package:flutter/foundation.dart';
import 'package:road_wave_fm_ui/constants/preferences.dart';
import 'package:road_wave_fm_ui/models/format_model.dart';
import 'package:road_wave_fm_ui/models/progress_model.dart';
import 'package:road_wave_fm_ui/services/format_service.dart';
import 'package:road_wave_fm_ui/data/format.dart';
import 'package:shared_preferences/shared_preferences.dart';

class FormatListModel extends ChangeNotifier {
  late ProgressModel progressModel;
  final FormatService _formatService;
  List<Format> _formats = [];
  List<FormatModel> _formatModels = [];
  final Set<String> _selectedFormatIds = <String>{};

  List<FormatModel> get formatModels => _formatModels;

  List<String> get selectedFormatIds => _selectedFormatIds.toList();

  FormatListModel(this._formatService);

  Future<void> fetchFormats() async {
    progressModel.start(FormatListModel);
    final preferences = await SharedPreferences.getInstance();
    final formats =
        preferences.get(describeEnum(Preference.formats)) as List<Format>?;

    if (formats != null) {
      _formats = formats;

      final selectedFormatIds =
          preferences.getStringList(describeEnum(Preference.selectedFormatIds));
      if (selectedFormatIds != null) {
        _selectedFormatIds.addAll(selectedFormatIds);
      }

      _buildFormatModels();
      progressModel.finish(FormatListModel);
      return;
    }

    _formats = await _formatService.getAll();

    _buildFormatModels();
    progressModel.finish(FormatListModel);
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
