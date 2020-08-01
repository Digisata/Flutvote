import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:flutter/foundation.dart';
import 'package:flutvote/model/models.dart';
import 'package:flutvote/providers/providers.dart';
import 'package:hive/hive.dart';
import 'package:package_info/package_info.dart';
import 'package:path_provider/path_provider.dart';

class HiveProviders with ChangeNotifier {
  static final Box _userData = Hive.box('userData');
  static String _deviceId = '', _appVersion = '';

  static openBox() async {
    try {
      final Directory _directory = await getApplicationDocumentsDirectory();
      Hive.init(_directory.path);
      await Hive.openBox('userData');
      if (_userData.isEmpty) {
        await _userData.put('isFirstOpened', true);
        await _userData.put('isFirstSignedIn', true);
        await _userData.put('isSetupCompleted', false);
      }
    } catch (error) {
      throw 'open box error: $error';
    }
  }

  static Future<void> syncUserData() async {
    UserModel _userModel = AppProviders.userModel;
    if (_userData.get('username') != _userModel.username ||
        _userData.get('email') != _userModel.email ||
        _userData.get('imageUrl') != _userModel.imageUrl ||
        _userData.get('displayName') != _userModel.displayName ||
        _userData.get('deviceId') != _userModel.deviceId ||
        _userData.get('isSetupCompleted') != _userModel.isSetupCompleted) {
      await _userData.put('username', _userModel.username);
      await _userData.put('email', _userModel.email);
      await _userData.put('imageUrl', _userModel.imageUrl);
      await _userData.put('displayName', _userModel.displayName);
      await _userData.put('deviceId', _userModel.deviceId);
      await _userData.put('isSetupCompleted', _userModel.isSetupCompleted);
    }
  }

  refreshUserData() {
    notifyListeners();
  }

  String get username => _userData.get('username');

  String get email => _userData.get('email');

  String get password => _userData.get('password');

  String get imageUrl => _userData.get('imageUrl');

  String get displayName => _userData.get('displayName');

  String get deviceId => _deviceId;

  String get appVersion => _appVersion;

  static bool getFirstOpened() => _userData.get('isFirstOpened');

  static bool getFirstSignedIn() => _userData.get('isFirstSignedIn');

  static bool getIsSetupCompleted() => _userData.get('isSetupCompleted');

  static void setAndroidId() async {
    final DeviceInfoPlugin _deviceInfoPlugin = DeviceInfoPlugin();
    try {
      final AndroidDeviceInfo _androidDeviceInfo =
          await _deviceInfoPlugin.androidInfo;
      _deviceId = _androidDeviceInfo.androidId;
    } catch (error) {
      throw 'set android id error: $error';
    }
  }

  static void setAppVersion() async {
    try {
      final PackageInfo _packageInfo = await PackageInfo.fromPlatform();
      _appVersion = _packageInfo.version;
    } catch (error) {
      throw 'set app info error: $error';
    }
  }

  void setPassword(String password) async {
    await _userData.put('password', password);
  }

  static void setFirstOpened() async {
    if (getFirstOpened()) {
      await _userData.put('isFirstOpened', false);
    }
  }

  static void setFirstSignedIn() async {
    if (getFirstSignedIn()) {
      await _userData.put('isFirstSignedIn', false);
    }
  }
}
