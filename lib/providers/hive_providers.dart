import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutvote/model/models.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class HiveProviders with ChangeNotifier {
  static bool _isBoxOpen = Hive.isBoxOpen('userData');

  static openBox() async {
    final Directory _directory = await getApplicationDocumentsDirectory();
    Hive.init(_directory.path);
    Hive.registerAdapter(UserDataAdapter());
    await Hive.openBox('userData');
  }

  void addData(String key, String value) async {
    final Box _userData = Hive.box('userData');
    _userData.add(UserData(key, value));
  }

  static bool get isBoxOpen => _isBoxOpen;
}
