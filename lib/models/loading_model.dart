import 'package:flutter/material.dart';

mixin LoadingModel on ChangeNotifier {
  bool _isLoading = false;

  bool get isLoading => _isLoading;

  @protected
  set isLoading(bool value) {
    if (_isLoading != value) {
      _isLoading = value;
      notifyListeners();
    }
  }

  @protected
  Future<T> runLoadFunc<T>(Future<T> Function() loadFunc) async {
    isLoading = true;
    final result = await loadFunc();
    isLoading = false;
    return result;
  }
}
