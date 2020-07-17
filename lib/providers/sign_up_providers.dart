import 'package:flutter/foundation.dart';

class SignUpProviders with ChangeNotifier {
  bool _isPasswordSignUpVisible = false, _isRepeatPasswordVisible = false;
  String _emailSignUp = '', _passwordSignUp = '', _repeatPassword = '';

  bool get isPasswordSignUpVisible => _isPasswordSignUpVisible;

  bool get isRepeatPasswordVisible => _isRepeatPasswordVisible;

  String get emailSignUp => _emailSignUp;

  String get passwordSignUp => _passwordSignUp;

  String get repeatPassword => _repeatPassword;

  set isPasswordSignUpVisible(bool value) {
    _isPasswordSignUpVisible = value;
    notifyListeners();
  }

  set isRepeatPasswordVisible(bool value) {
    _isRepeatPasswordVisible = value;
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

  set repeatPassword(String value) {
    _repeatPassword = value;
    notifyListeners();
  }
}
