import 'package:flutter/foundation.dart';

class ChangePasswordProviders with ChangeNotifier {
  bool _isOldPasswordChangeVisible = false,
      _isNewPasswordChangeVisible = false,
      _isNewRepeatPasswordChangeVisible = false;
  String _oldPasswordChange = '',
      _newPasswordChange = '',
      _newRepeatPasswordChange = '';

  bool get isOldPasswordChangeVisible => _isOldPasswordChangeVisible;

  bool get isNewPasswordChangeVisible => _isNewPasswordChangeVisible;

  bool get isNewRepeatPasswordChangeVisible =>
      _isNewRepeatPasswordChangeVisible;

  String get oldPasswordChange => _oldPasswordChange;

  String get newPasswordChange => _newPasswordChange;

  String get newRepeatPasswordChange => _newRepeatPasswordChange;

  set isOldPasswordChangeVisible(bool value) {
    _isOldPasswordChangeVisible = value;
    notifyListeners();
  }

  set isNewPasswordChangeVisible(bool value) {
    _isNewPasswordChangeVisible = value;
    notifyListeners();
  }

  set isNewRepeatPasswordChangeVisible(bool value) {
    _isNewRepeatPasswordChangeVisible = value;
    notifyListeners();
  }

  set oldPasswordChange(String value) {
    _oldPasswordChange = value;
    notifyListeners();
  }

  set newPasswordChange(String value) {
    _newPasswordChange = value;
    notifyListeners();
  }

  set newRepeatPasswordChange(String value) {
    _newRepeatPasswordChange = value;
    notifyListeners();
  }
}
