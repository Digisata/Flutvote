import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutvote/model/models.dart';
import 'package:flutvote/services/services.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class HiveProviders with ChangeNotifier {
  static final Box _userData = Hive.box('userData');

  static openBox() async {
    final Directory _directory = await getApplicationDocumentsDirectory();
    Hive.init(_directory.path);
    Hive.registerAdapter(UserDataAdapter());
    await Hive.openBox('userData');
    _userData.add(UserData());
  }

  static bool getFirstOpened() => _userData.getAt(0).isFirstOpened;

  static bool getFirstSignedIn() => _userData.getAt(0).isFirstSignedIn;

  static void setFirstOpened() async {
    await _userData.putAt(0, UserData(isFirstOpened: false));
  }

  static void setFirstSignedIn() async {
    await _userData.putAt(0, UserData(isFirstSignedIn: false));
  }

  void setUserData() async {
    final FirebaseService _firebaseService = FirebaseService();
    final FirebaseUser _firebaseUser = await _firebaseService.getCurrentUser();
    _userData.putAt(
      0,
      UserData(
        userName: 'digisata',
        email: _firebaseUser.email,
        displayName: 'Hanif Naufal',
      ),
    );
  }
}
