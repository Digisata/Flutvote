import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutvote/model/models.dart';
import 'package:flutvote/services/services.dart';

class SignInProviders with ChangeNotifier {
  bool _isPasswordSignInVisible = false;
  String _emailSignIn = '', _passwordSignIn = '';
  UserModel _userModel;

  void createUserModel() async {
    final FirebaseService _firebaseService = FirebaseService();
    final FirebaseUser _firebaseUser = await _firebaseService.getCurrentUser();
    _userModel = UserModel(
      'digisata',
      _firebaseUser.email,
      'Hanif Naufal',
    );
    notifyListeners();
  }

  bool get isPasswordSignInVisible => _isPasswordSignInVisible;

  String get emailSignIn => _emailSignIn;

  String get passwordSignIn => _passwordSignIn;

  UserModel get userModel => _userModel;

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
