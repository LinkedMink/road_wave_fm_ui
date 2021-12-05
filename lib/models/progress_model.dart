import 'dart:async';

import 'package:flutter/foundation.dart';

class ProgressModel extends ChangeNotifier {
  static const _completeNotifyDelay = Duration(milliseconds: 250);
  static const _indefiniteStep = Duration(milliseconds: 100);
  static const _defaultEstimatedTime = Duration(seconds: 1, milliseconds: 250);
  bool _isLoading = false;
  bool _isIndefinite = false;
  Timer? _indefiniteTimer;
  double _proportionComplete = 0;

  bool get isLoading => _isLoading;

  bool get isIndefinite => _isIndefinite;

  double get proportionComplete => _proportionComplete;
  set proportionComplete(double value) {
    _proportionComplete = value;
    notifyListeners();
  }

  void finish() {
    _proportionComplete = 1;
    _indefiniteTimer?.cancel();
    notifyListeners();

    Timer(_completeNotifyDelay, () {
      _isLoading = false;
      notifyListeners();
    });
  }

  void start() {
    _proportionComplete = 0;
    _isLoading = true;
    _isIndefinite = false;
    notifyListeners();
  }

  void startIndefinite({Duration estimatedTime = _defaultEstimatedTime}) {
    _proportionComplete = 0;
    _isLoading = true;
    _isIndefinite = true;

    // todo: should decrease rate of progress as we approach estimated time
    final linearSteps =
        (_defaultEstimatedTime.inMilliseconds / _indefiniteStep.inMilliseconds)
            .floor();
    var step = 0;
    _indefiniteTimer = Timer.periodic(_indefiniteStep, (timer) {
      if (step == linearSteps) {
        proportionComplete = 0.95;
        timer.cancel();
        return;
      }

      proportionComplete = step / linearSteps;
      step++;
    });

    notifyListeners();
  }
}
