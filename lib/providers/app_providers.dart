import 'package:flutter/foundation.dart';

class AppProviders with ChangeNotifier {
  bool _isPasswordVisible = false;

  void showHidePassword() {
    _isPasswordVisible = !_isPasswordVisible;
    notifyListeners();
  }

  bool get isPasswordVisible => _isPasswordVisible;
}
