import 'package:flutter/foundation.dart';

class AppProviders with ChangeNotifier {
  bool _isLoading = false,
      _isPasswordSignInVisible = false,
      _isPasswordSignUpVisible = false,
      _isConfirmPasswordVisible = false;
  String _emailInput, _passwordInput, _confirmPasswordInput;

  bool get isLoading => _isLoading;

  bool get isPasswordSignInVisible => _isPasswordSignInVisible;

  bool get isPasswordSignUpVisible => _isPasswordSignUpVisible;

  bool get isConfirmPasswordVisible => _isConfirmPasswordVisible;

  String get emailInput => _emailInput;

  String get passwordInput => _passwordInput;

  String get confirmPasswordInput => _confirmPasswordInput;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

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

  set emailInput(String value) {
    _emailInput = value;
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
