import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';

abstract class BaseAuth {
  Future<String> signInWithEmailPassword(String email, String password);
  Future<String> signUpWithEmailPassword(String email, String password);
  Future<FirebaseUser> getCurrentUser();
  Future<void> sendEmailVerification();
  Future<void> signOut();
  Future<bool> isEmailVerified();
}

class FirebaseAuths implements BaseAuth {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FacebookLogin _facebookLogin = FacebookLogin();

  Future<String> signInWithEmailPassword(String email, String password) async {
    AuthResult _result = await _firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
    assert(_result != null);
    FirebaseUser _user = _result.user;
    assert(_user != null);
    return _user.uid;
  }

  Future<String> signUpWithEmailPassword(String email, String password) async {
    AuthResult _result = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
    assert(_result != null);
    FirebaseUser _user = _result.user;
    assert(_user != null);
    return _user.uid;
  }

  Future<FirebaseUser> getCurrentUser() async {
    FirebaseUser _user = await _firebaseAuth.currentUser();
    return _user;
  }

  Future<void> signOut() async {
    try {
      await _firebaseAuth.signOut();
      await _facebookLogin.logOut();
    } catch (error) {
      throw 'catch error: $error';
    }
  }

  Future<void> sendEmailVerification() async {
    FirebaseUser _user = await _firebaseAuth.currentUser();
    assert(_user != null);
    _user.sendEmailVerification();
  }

  Future<bool> isEmailVerified() async {
    FirebaseUser _user = await _firebaseAuth.currentUser();
    assert(_user != null);
    return _user.isEmailVerified;
  }
}
