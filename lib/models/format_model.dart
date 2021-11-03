import 'package:flutter/foundation.dart';
import 'package:road_wave_fm_ui/data/format.dart';

class FormatModel extends Format with ChangeNotifier {
  bool _isSelected;

  bool get isSelected => _isSelected;

  set isSelected(bool isSelected) {
    _isSelected = isSelected;
    notifyListeners();
  }

  FormatModel(Format format, this._isSelected) : super(format.id, format.name);
}
