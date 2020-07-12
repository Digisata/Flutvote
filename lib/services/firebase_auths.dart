import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

abstract class BaseAuth {
  Future<FirebaseUser> signInWithEmailPassword(String email, String password);
  Future<FirebaseUser> signUpWithEmailAndPassword(String email, String password);
  Future<FirebaseUser> getCurrentUser();
  Future<void> sendEmailVerification();
  Future<void> signOut();
  Future<bool> isEmailVerified();
}

class FirebaseAuths implements BaseAuth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FacebookLogin _facebookLogin = FacebookLogin();

  Future<FirebaseUser> signInWithEmailPassword(
    String email,
    String password,
  ) async {
    try {
      final AuthResult _result = await _firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      assert(_result != null);
      FirebaseUser _user = _result.user;
      assert(_user != null);
      return _user;
    } catch (error) {
      throw 'sign in with email and password error: $error';
    }
  }

  Future<FirebaseUser> signUpWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      final AuthResult _result = await _firebaseAuth
          .createUserWithEmailAndPassword(email: email, password: password);
      assert(_result != null);
      FirebaseUser _user = _result.user;
      assert(_user != null);
      return _user;
    } catch (error) {
      throw 'sign up with email and password error: $error';
    }
  }

  Future<FirebaseUser> getCurrentUser() async {
    try {
      final FirebaseUser _user = await _firebaseAuth.currentUser();
      return _user;
    } catch (error) {
      throw 'get current user error: $error';
    }
  }

  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
      await _facebookLogin.logOut();
    } catch (error) {
      throw 'sign out error: $error';
    }
  }

  Future<void> sendEmailVerification() async {
    try {
      final FirebaseUser _user = await _firebaseAuth.currentUser();
      assert(_user != null);
      _user.sendEmailVerification();
    } catch (error) {
      throw 'send email verfication error: $error';
    }
  }

  Future<bool> isEmailVerified() async {
    try {
      final FirebaseUser _user = await _firebaseAuth.currentUser();
      assert(_user != null);
      return _user.isEmailVerified;
    } catch (error) {
      throw 'is email verified error: $error';
    }
  }
}
