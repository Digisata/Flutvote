import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutvote/model/models.dart';
import 'package:flutvote/services/services.dart';

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
