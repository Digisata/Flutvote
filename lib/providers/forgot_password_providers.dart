import 'package:flutter/foundation.dart';

class ForgotPasswordProviders with ChangeNotifier {
  String _emailForgotPassword = '';

  String get emailForgotPassword => _emailForgotPassword;

  set emailForgotPassword(String value) {
    _emailForgotPassword = value;
    notifyListeners();
  }
}
