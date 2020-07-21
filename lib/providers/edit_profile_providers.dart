import 'package:flutter/foundation.dart';

class EditProfileProviders with ChangeNotifier {
  String _displayNameChange = '', _usernameChange = '';

  String get displayNameChange => _displayNameChange;

  String get usernameChange => _usernameChange;

  set displayNameChange(String value) {
    _displayNameChange = value;
    notifyListeners();
  }

  set usernameChange(String value) {
    _usernameChange = value;
    notifyListeners();
  }
}
