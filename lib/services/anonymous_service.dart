import 'package:firebase_auth/firebase_auth.dart';

class AnonymousService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  void signInAnonymously() async {
    try {
      final AuthResult _authResult = await _firebaseAuth.signInAnonymously();
      assert(_authResult != null);
    } catch (error) {
      throw 'catch error: $error';
    }
  }
}
