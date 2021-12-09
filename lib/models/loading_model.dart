import 'package:flutter/material.dart';

mixin LoadingModel on ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  @protected
  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }
}
