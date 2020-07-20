import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutvote/model/models.dart';
import 'package:flutvote/providers/providers.dart';
import 'package:flutvote/services/services.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class HiveProviders with ChangeNotifier {
  static final Box _userData = Hive.box('userData');
  static UserModel _userModel = AppProviders.userModel;

  static openBox() async {
    final Directory _directory = await getApplicationDocumentsDirectory();
    Hive.init(_directory.path);
    await Hive.openBox('userData');
    if (_userData.isEmpty) {
      await _userData.put('isFirstOpened', true);
      await _userData.put('isFirstSignedIn', true);
    }
  }

  static bool getFirstOpened() => _userData.get('isFirstOpened');

  static bool getFirstSignedIn() => _userData.get('isFirstSignedIn');

  static void setFirstOpened() async {
    await _userData.put('isFirstOpened', false);
  }

  static void setFirstSignedIn() async {
    await _userData.put('isFirstSignedIn', false);
  }

  static void syncUserData() async {
    final FirebaseService _firebaseService = FirebaseService();
    final FirebaseUser _user = await _firebaseService.getCurrentUser();
    if (_userData.get('username') != _userModel.username) {
      await _userData.put('username', _userModel.username);
    }
    if (_userData.get('email') != _userModel.email) {
      await _userData.put('email', _user.email);
    }
    if (_userData.get('displayName') != _userModel.displayName) {
      await _userData.put('displayName', 'Hanif Naufal');
    }
  }
}
