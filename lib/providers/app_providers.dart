import 'package:flutter/foundation.dart';

class AppProviders with ChangeNotifier {
  bool _isPasswordVisible = false, _isConfirmPasswordVisible = false;

  void showHidePassword() {
    _isPasswordVisible = !_isPasswordVisible;
    notifyListeners();
  }

  void showHideConfirmPassword() {
    _isConfirmPasswordVisible = !_isConfirmPasswordVisible;
    notifyListeners();
  }

  bool get isPasswordVisible => _isPasswordVisible;
  bool get isConfirmPasswordVisible => _isConfirmPasswordVisible;
}
