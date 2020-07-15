import 'package:flutter/foundation.dart';

class SignUpProviders with ChangeNotifier {
  bool _isPasswordSignUpVisible = false, _isConfirmPasswordVisible = false;
  String _emailSignUp = '', _passwordSignUp = '', _confirmPassword = '';

  bool get isPasswordSignUpVisible => _isPasswordSignUpVisible;

  bool get isConfirmPasswordVisible => _isConfirmPasswordVisible;

  String get emailSignUp => _emailSignUp;

  String get passwordSignUp => _passwordSignUp;

  String get confirmPassword => _confirmPassword;

  set isPasswordSignUpVisible(bool value) {
    _isPasswordSignUpVisible = value;
    notifyListeners();
  }

  set isConfirmPasswordVisible(bool value) {
    _isConfirmPasswordVisible = value;
    notifyListeners();
  }

  set emailSignUp(String value) {
    _emailSignUp = value;
    notifyListeners();
  }

  set passwordSignUp(String value) {
    _passwordSignUp = value;
    notifyListeners();
  }

  set confirmPassword(String value) {
    _confirmPassword = value;
    notifyListeners();
  }
}
