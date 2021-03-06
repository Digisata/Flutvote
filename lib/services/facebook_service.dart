import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_facebook_login/flutter_facebook_login.dart';
import 'package:flutvote/commons/commons.dart';

class FacebookService {
  final FacebookLogin _facebookLogin = FacebookLogin();
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  signInWithFacebook() async {
    final _facebookLoginResult = await _facebookLogin.logIn(['email']);
    assert(_facebookLoginResult != null);
    final String _accessToken = _facebookLoginResult.accessToken.token;
    assert(_accessToken != null);

    switch (_facebookLoginResult.status) {
      case FacebookLoginStatus.error:
        throw ContentTexts.errorFacebookSignIn;
        break;
      case FacebookLoginStatus.cancelledByUser:
        throw ContentTexts.errorFacebookCancel;
        break;
      case FacebookLoginStatus.loggedIn:
        final AuthCredential _authCredential = FacebookAuthProvider.getCredential(
          accessToken: _accessToken,
        );
        assert(_authCredential != null);
        final FirebaseUser _user =
            (await _firebaseAuth.signInWithCredential(_authCredential)).user;
        assert(_user != null);
        assert(_user.displayName != null);
        assert(_user.photoUrl != null);
        assert(!_user.isAnonymous);
        return _user;
        break;
    }
  }
}
