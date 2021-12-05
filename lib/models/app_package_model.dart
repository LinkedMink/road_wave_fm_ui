import 'package:flutter/foundation.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AppPackageModel extends ChangeNotifier {
  bool _isInitialized = false;
  String version = '';
  String buildNumber = '';

  bool get isInitialized => _isInitialized;

  Future<PackageInfo> initialize() async {
    final packageInfo = await PackageInfo.fromPlatform();
    version = packageInfo.version;
    buildNumber = packageInfo.buildNumber;
    _isInitialized = true;
    notifyListeners();
    return packageInfo;
  }
}
