import 'dart:async';

import 'package:flutter/foundation.dart';

class ProgressModel extends ChangeNotifier {
  static const _completeNotifyDelay = Duration(milliseconds: 200);
  final Map<Type, double?> _progressingTasks = {};

  bool get isLoading => _progressingTasks.isNotEmpty;

  // If any task is indeterminant, show as indeterminant. Otherwise, select the task
  // with the least progress
  double? get proportionComplete => _progressingTasks.values.fold(
      1,
      (previousValue, element) => previousValue == null || element == null
          ? null
          : element < previousValue
              ? element
              : previousValue);

  void finish(Type loader) {
    _progressingTasks.remove(loader);

    if (isLoading) {
      return;
    }

    Timer(_completeNotifyDelay, () {
      notifyListeners();
    });
  }

  void start(Type loader, {bool isIndeterminant = true}) {
    _progressingTasks[loader] = isIndeterminant ? null : 0;
    notifyListeners();
  }

  void progress(Type loader, double proportion) {
    _progressingTasks[loader] = proportion;
    notifyListeners();
  }
}
