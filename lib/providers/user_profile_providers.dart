import 'package:flutter/foundation.dart';

class UserProfileProviders with ChangeNotifier {
  String _username = '', _photoUrl = '', _displayName = '';

  String get username => _username;

  String get photoUrl => _photoUrl;

  String get displayName => _displayName;

  set username(String value) {
    _username = value;
    notifyListeners();
  }

  set photoUrl(String value) {
    _photoUrl = value;
    notifyListeners();
  }

  set displayName(String value) {
    _displayName = value;
    notifyListeners();
  }
}
