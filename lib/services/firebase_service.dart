import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutvote/commons/commons.dart';

abstract class BaseService {
  Future<void> signInWithEmailPassword(String email, String password);
  Future<void> signUpWithEmailAndPassword(String email, String password);
  Future<FirebaseUser> getCurrentUser();
  Future<void> resetPassword(String email);
  Future<void> sendEmailVerification();
  Future<void> signOut();
  Future<bool> isEmailVerified();
  Future<bool> validatePassword(String password);
  Future<void> updatePassword(String password);
}

class EmailVerifyException implements Exception {}

class FirebaseService implements BaseService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
  final FacebookLogin _facebookLogin = FacebookLogin();

  Future<void> signInWithEmailPassword(
    String email,
    String password,
  ) async {
    try {
      final AuthResult _result = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      assert(_result != null);
      FirebaseUser _user = _result.user;
      assert(_user != null);
      assert(!_user.isAnonymous);
      if (!_user.isEmailVerified) {
        throw EmailVerifyException();
      }
    } on EmailVerifyException {
      throw ContentTexts.verifyEmail;
    } catch (error) {
      switch (error.code) {
        case 'ERROR_INVALID_EMAIL':
          throw ContentTexts.errorInvalidEmail;
          break;
        case 'ERROR_WRONG_PASSWORD':
          throw ContentTexts.errorWrongPassword;
          break;
        case 'ERROR_USER_NOT_FOUND':
          throw ContentTexts.errorUserNotFound;
          break;
        case 'ERROR_USER_DISABLED':
          throw ContentTexts.errorUserDisabled;
          break;
        case 'ERROR_TOO_MANY_REQUESTS':
          throw ContentTexts.errorTooManyRequest;
          break;
        case 'ERROR_OPERATION_NOT_ALLOWED':
          throw ContentTexts.errorOperationNotAllowed;
          break;
        default:
          throw ContentTexts.errorUnknown;
      }
    }
  }

  Future<void> signUpWithEmailAndPassword(
    String email,
    String password,
  ) async {
    try {
      final AuthResult _result =
          await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      assert(_result != null);
      FirebaseUser _user = _result.user;
      assert(_user != null);
      assert(!_user.isAnonymous);
      await _user.sendEmailVerification();
    } catch (error) {
      switch (error.code) {
        case 'ERROR_WEAK_PASSWORD':
          throw ContentTexts.errorWeakPassword;
          break;
        case 'ERROR_INVALID_EMAIL':
          throw ContentTexts.errorInvalidEmailFormatted;
          break;
        case 'ERROR_EMAIL_ALREADY_IN_USE':
          throw ContentTexts.errorEmailAlreadyInUse;
          break;
        default:
          throw ContentTexts.errorUnknown;
      }
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

  Future<bool> validatePassword(String password) async {
    final FirebaseUser _user = await getCurrentUser();
    final AuthCredential _authCredentials = EmailAuthProvider.getCredential(
      email: _user.email,
      password: password,
    );
    try {
      final AuthResult _authResult =
          await _user.reauthenticateWithCredential(_authCredentials);
      return _authResult.user != null;
    } catch (error) {
      switch (error.code) {
        case 'ERROR_INVALID_CREDENTIAL':
          throw ContentTexts.errorInvalidCredentials;
          break;
        case 'ERROR_WRONG_PASSWORD':
          throw ContentTexts.errorWrongPassword;
          break;
        case 'ERROR_USER_DISABLED':
          throw ContentTexts.errorUserDisabled;
          break;
        case 'ERROR_USER_NOT_FOUND':
          throw ContentTexts.errorUserNotFound;
          break;
        case 'ERROR_OPERATION_NOT_ALLOWED':
          throw ContentTexts.errorOperationNotAllowed;
          break;
        default:
          throw ContentTexts.errorUnknown;
      }
    }
  }

  Future<void> updatePassword(String password) async {
    final FirebaseUser _user = await getCurrentUser();
    try {
      _user.updatePassword(password);
    } catch (error) {
      switch (error.code) {
        case 'ERROR_WEAK_PASSWORD':
          throw ContentTexts.errorWeakPassword;
          break;
        case 'ERROR_USER_DISABLED':
          throw ContentTexts.errorUserDisabled;
          break;
        case 'ERROR_USER_NOT_FOUND':
          throw ContentTexts.errorUserNotFound;
          break;
        case 'ERROR_REQUIRES_RECENT_LOGIN':
          throw ContentTexts.errorRequiresRecentLogin;
          break;
        case 'ERROR_OPERATION_NOT_ALLOWED':
          throw ContentTexts.errorOperationNotAllowed;
          break;
        default:
          throw ContentTexts.errorUnknown;
      }
    }
  }

  Future<void> resetPassword(String email) async {
    try {
      await _firebaseAuth.sendPasswordResetEmail(email: email);
    } catch (error) {
      switch (error.code) {
        case 'ERROR_INVALID_EMAIL':
          throw ContentTexts.errorInvalidEmail;
          break;
        case 'ERROR_USER_NOT_FOUND':
          throw ContentTexts.errorUserNotFound;
          break;
        default:
          throw ContentTexts.errorUnknown;
      }
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
