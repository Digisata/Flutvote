import 'dart:io';

import 'package:flutter/foundation.dart';

class EditProfileProviders with ChangeNotifier {
  File _image;
  bool _isHasError = false;

  File get image => _image;

  bool get isHasError => _isHasError;

  set image(File value) {
    _image = value;
    notifyListeners();
  }

  set isHasError(bool value) {
    _isHasError = value;
    notifyListeners();
  }
}
