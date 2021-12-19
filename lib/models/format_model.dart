import 'package:flutter/foundation.dart';

import '/data/format.dart';

// ignore: must_be_immutable
class FormatModel extends Format with ChangeNotifier {
  bool _isSelected;

  bool get isSelected => _isSelected;

  set isSelected(bool isSelected) {
    if (_isSelected != isSelected) {
      _isSelected = isSelected;
      notifyListeners();
    }
  }

  bool toggle() => isSelected = !isSelected;

  FormatModel(Format format, this._isSelected) : super(format.id, format.name);
}
