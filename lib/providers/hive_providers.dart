import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

class HiveProviders with ChangeNotifier {
  Box _hiveBox;

  openBox() async {
    final Directory _directory = await getApplicationDocumentsDirectory();
    Hive.init(_directory.path);
    await Hive.openBox('userData');
  }

  void putData(String key, String value) async {
    _hiveBox = Hive.box('userData');
    _hiveBox.put(key, value);
  }

  String getData(String key) => _hiveBox.get(key);
}
