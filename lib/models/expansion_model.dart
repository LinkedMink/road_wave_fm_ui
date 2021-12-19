import 'package:flutter/foundation.dart';

class ExpansionModel extends ChangeNotifier {
  bool _isExpanded;

  bool get isExpanded => _isExpanded;

  set isExpanded(bool isExpanded) {
    if (_isExpanded != isExpanded) {
      _isExpanded = isExpanded;
      notifyListeners();
    }
  }

  ExpansionModel({isExpanded = false}) : _isExpanded = isExpanded;

  bool toggle() => isExpanded = !isExpanded;
}
