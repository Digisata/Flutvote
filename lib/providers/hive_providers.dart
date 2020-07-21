import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutvote/model/models.dart';
import 'package:flutvote/providers/providers.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class HiveProviders with ChangeNotifier {
  static final Box _userData = Hive.box('userData');

  static openBox() async {
    try {
      final Directory _directory = await getApplicationDocumentsDirectory();
      Hive.init(_directory.path);
      await Hive.openBox('userData');
      if (_userData.isEmpty) {
        await _userData.put('isFirstOpened', true);
        await _userData.put('isFirstSignedIn', true);
      }
    } catch (error) {
      throw 'open box error: $error';
    }
  }

  String get username => _userData.get('username');

  String get email => _userData.get('email');

  String get displayName => _userData.get('displayName');

  static bool getFirstOpened() => _userData.get('isFirstOpened');

  static bool getFirstSignedIn() => _userData.get('isFirstOpened');

  static void setFirstOpened() async {
    await _userData.put('isFirstOpened', false);
  }

  static void setFirstSignedIn() async {
    await _userData.put('isFirstSignedIn', false);
  }

  static void syncUserData() async {
    UserModel _userModel = AppProviders.userModel;
    if (_userData.get('username') != _userModel.username ||
        _userData.get('email') != _userModel.email ||
        _userData.get('displayName') != _userModel.displayName) {
      await _userData.put('username', _userModel.username);
      await _userData.put('email', _userModel.email);
      await _userData.put('displayName', _userModel.displayName);
    }
  }
}
