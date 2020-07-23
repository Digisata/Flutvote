import 'package:flutter/foundation.dart';

class UserProfileProviders with ChangeNotifier {
  String _displayName = '', _username = '';

  String get displayName => _displayName;

  String get username => _username;

  set displayName(String value) {
    _displayName = value;
    notifyListeners();
  }

  set username(String value) {
    _username = value;
    notifyListeners();
  }
}
