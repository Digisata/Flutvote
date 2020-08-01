import 'package:flutter/foundation.dart';

class UserProfileProviders with ChangeNotifier {
  String _username = '', _imageUrl = '', _displayName = '';

  String get username => _username;

  String get imageUrl => _imageUrl;

  String get displayName => _displayName;

  set username(String value) {
    _username = value;
    notifyListeners();
  }

  set imageUrl(String value) {
    _imageUrl = value;
    notifyListeners();
  }

  set displayName(String value) {
    _displayName = value;
    notifyListeners();
  }
}
