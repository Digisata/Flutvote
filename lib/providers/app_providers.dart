import 'package:flutter/foundation.dart';

class AppProviders with ChangeNotifier {
  bool _isPasswordSignInVisible = false,
      _isPasswordSignUpVisible = false,
      _isConfirmPasswordVisible = false;
  String _passwordInput, _confirmPasswordInput;

  bool get isPasswordSignInVisible => _isPasswordSignInVisible;

  bool get isPasswordSignUpVisible => _isPasswordSignUpVisible;

  bool get isConfirmPasswordVisible => _isConfirmPasswordVisible;

  String get passwordInput => _passwordInput;

  String get confirmPasswordInput => _confirmPasswordInput;

  set isPasswordSignInVisible(bool value) {
    _isPasswordSignInVisible = value;
    notifyListeners();
  }

  set isPasswordSignUpVisible(bool value) {
    _isPasswordSignUpVisible = value;
    notifyListeners();
  }

  set isConfirmPasswordVisible(bool value) {
    _isConfirmPasswordVisible = value;
    notifyListeners();
  }

  set passwordInput(String value) {
    _passwordInput = value;
    notifyListeners();
  }

  set confirmPasswordInput(String value) {
    _confirmPasswordInput = value;
    notifyListeners();
  }
}
