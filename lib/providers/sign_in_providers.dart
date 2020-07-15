import 'package:flutter/foundation.dart';

class SignInProviders with ChangeNotifier {
  bool _isPasswordSignInVisible = false;
  String _emailSignIn = '', _passwordSignIn = '';

  bool get isPasswordSignInVisible => _isPasswordSignInVisible;

  String get emailSignIn => _emailSignIn;

  String get passwordSignIn => _passwordSignIn;

  set isPasswordSignInVisible(bool value) {
    _isPasswordSignInVisible = value;
    notifyListeners();
  }

  set emailSignIn(String value) {
    _emailSignIn = value;
    notifyListeners();
  }

  set passwordSignIn(String value) {
    _passwordSignIn = value;
    notifyListeners();
  }
}
