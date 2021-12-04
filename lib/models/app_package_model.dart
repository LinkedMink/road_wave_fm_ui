import 'package:flutter/foundation.dart';
import 'package:package_info_plus/package_info_plus.dart';

class AppPackageModel extends ChangeNotifier {
  late String version;
  late String buildNumber;

  Future<PackageInfo> initialize() async {
    final packageInfo = await PackageInfo.fromPlatform();
    version = packageInfo.version;
    buildNumber = packageInfo.buildNumber;
    notifyListeners();
    return packageInfo;
  }
}
