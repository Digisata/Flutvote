import 'package:flutter/foundation.dart';
import 'package:flutvote/model/models.dart';

class AppProviders with ChangeNotifier {
  bool _isLoading = false;
  static UserModel _userModel;
  static PostModel _postModel;

  bool get isLoading => _isLoading;

  static UserModel get userModel => _userModel;

  static PostModel get postModel => _postModel;

  set isLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  static set setUserModel(UserModel value) {
    _userModel = value;
  }

  static set setPostModel(PostModel value) {
    _postModel = value;
  }
}
