import 'package:flutter/foundation.dart';

class SignUpProviders with ChangeNotifier {
  bool _isPasswordSignUpVisible = false, _isRepeatPasswordSignUpVisible = false;
  String _emailSignUp = '', _passwordSignUp = '', _repeatPasswordSignUp = '';

  bool get isPasswordSignUpVisible => _isPasswordSignUpVisible;

  bool get isRepeatPasswordSignUpVisible => _isRepeatPasswordSignUpVisible;

  String get emailSignUp => _emailSignUp;

  String get passwordSignUp => _passwordSignUp;

  String get repeatPasswordSignUp => _repeatPasswordSignUp;

  set isPasswordSignUpVisible(bool value) {
    _isPasswordSignUpVisible = value;
    notifyListeners();
  }

  set isRepeatPasswordSignUpVisible(bool value) {
    _isRepeatPasswordSignUpVisible = value;
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

  set repeatPasswordSignUp(String value) {
    _repeatPasswordSignUp = value;
    notifyListeners();
  }
}
