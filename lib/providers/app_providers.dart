import 'package:flutter/foundation.dart';
import 'package:flutvote/model/models.dart';

class AppProviders with ChangeNotifier {
  bool _isLoading = false;
  static UserModel _userModel;

  bool get isLoading => _isLoading;

  static UserModel get userModel => _userModel;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  static set setUserModel(UserModel value) {
    _userModel = value;
  }
}
