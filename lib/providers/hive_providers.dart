import 'dart:io';

import 'package:device_info/device_info.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutvote/model/models.dart';
import 'package:flutvote/providers/providers.dart';
import 'package:flutvote/services/services.dart';
import 'package:hive/hive.dart';
import 'package:package_info/package_info.dart';
import 'package:path_provider/path_provider.dart';

class HiveProviders with ChangeNotifier {
  static final Box _userData = Hive.box('userData');
  static final FirebaseService _firebaseService = FirebaseService();
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
    final UserModel _userModel = AppProviders.userModel;
    final FirebaseUser _user = await _firebaseService.getCurrentUser();

    if (_userData.get('deviceId') != _userModel.deviceId) {
      await _userData.put('deviceId', _userModel.deviceId);
    }

    if (_userData.get('displayName') != _userModel.displayName) {
      await _userData.put('displayName', _userModel.displayName);
    }

    if (_userData.get('email') != _userModel.email) {
      await _userData.put('email', _userModel.email);
    }

    if (_userData.get('is2FAConfigured') != _userModel.is2FAConfigured) {
      await _userData.put('is2FAConfigured', _userModel.is2FAConfigured);
    }

    if (_userData.get('isFingerprintConfigured') !=
        _userModel.isFingerprintConfigured) {
      await _userData.put(
          'isFingerprintConfigured', _userModel.isFingerprintConfigured);
    }

    if (_userData.get('isPinConfigured') != _userModel.isPinConfigured) {
      await _userData.put('isPinConfigured', _userModel.isPinConfigured);
    }

    if (_userData.get('isSetupCompleted') != _userModel.isSetupCompleted) {
      await _userData.put('isSetupCompleted', _userModel.isSetupCompleted);
    }

    if (_userData.get('photoUrl') != _userModel.photoUrl) {
      await _userData.put('photoUrl', _userModel.photoUrl);
    }

    if (_userData.get('uid') != _user.uid) {
      await _userData.put('uid', _user.uid);
    }

    if (_userData.get('username') != _userModel.username) {
      await _userData.put('username', _userModel.username);
    }
  }

  refreshUserData() {
    notifyListeners();
  }

  String get appVersion => _appVersion;

  String get deviceId => _deviceId;

  String get displayName => _userData.get('displayName');

  String get email => _userData.get('email');

  static bool getFirstOpened() => _userData.get('isFirstOpened');

  static bool getFirstSignedIn() => _userData.get('isFirstSignedIn');

  static bool getIsSetupCompleted() => _userData.get('isSetupCompleted');

  String get password => _userData.get('password');

  String get photoUrl => _userData.get('photoUrl');

  String get uid => _userData.get('uid');

  String get username => _userData.get('username');

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

  void setPassword(String password) async {
    await _userData.put('password', password);
  }
}
