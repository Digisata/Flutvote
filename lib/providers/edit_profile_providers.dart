import 'dart:io';

import 'package:flutter/foundation.dart';

class EditProfileProviders with ChangeNotifier {
  File _image;

  File get image => _image;

  set image(File value) {
    _image = value;
    notifyListeners();
  }
}
