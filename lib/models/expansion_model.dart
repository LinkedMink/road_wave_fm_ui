import 'package:flutter/foundation.dart';

class ExpansionModel extends ChangeNotifier {
  bool _isExpanded;

  bool get isExpanded => _isExpanded;

  set isExpanded(bool isExpanded) {
    _isExpanded = isExpanded;
    notifyListeners();
  }

  ExpansionModel({isExpanded = false}) : _isExpanded = isExpanded;

  toggle() => isExpanded = !isExpanded;
}
