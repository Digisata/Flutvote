import 'package:flutter/foundation.dart';
import 'package:flutvote/model/models.dart';
import 'package:package_info/package_info.dart';

class AppProviders with ChangeNotifier {
  bool _isLoading = false;
  static String _appVersion = '';
  static UserModel _userModel;

  bool get isLoading => _isLoading;

  String get appVersion => _appVersion;

  static UserModel get userModel => _userModel;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  static void setAppVersion() async {
    try {
      final PackageInfo _packageInfo = await PackageInfo.fromPlatform();
      _appVersion = _packageInfo.version;
    } catch (error) {
      throw 'get app info error: $error';
    }
  }

  static set setUserModel(UserModel value) {
    _userModel = value;
  }
}
