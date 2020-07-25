import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutvote/model/models.dart';
import 'package:flutvote/providers/providers.dart';
import 'package:flutvote/services/services.dart';

class FirestoreService {
  final CollectionReference _collectionReference =
      Firestore.instance.collection('users');
  final FirebaseService _firebaseService = FirebaseService();

  Future<bool> isUserExist() async {
    try {
      final FirebaseUser _user = await _firebaseService.getCurrentUser();
      assert(_user != null);
      final DocumentSnapshot _document =
          await _collectionReference.document(_user.uid).get();
      assert(_document != null);
      return _document.exists;
    } catch (error) {
      throw 'is user exist error: $error';
    }
  }

  Future<void> fetchUserData() async {
    try {
      final FirebaseUser _user = await _firebaseService.getCurrentUser();
      assert(_user != null);
      final DocumentSnapshot _document =
          await _collectionReference.document(_user.uid).get();
      assert(_document != null);
      AppProviders.setUserModel = UserModel.fromMap(_document.data);
    } catch (error) {
      throw 'get data error: $error';
    }
  }

  Future<void> setUserData(UserModel userModel) async {
    try {
      final FirebaseUser _user = await _firebaseService.getCurrentUser();
      assert(_user != null);
      await _collectionReference.document(_user.uid).setData(
            userModel.toMap(),
            merge: true,
          );
    } catch (error) {
      throw 'set data error: $error';
    }
  }

  Future<void> updateUsernameAndDisplayName(UserModel userModel) async {
    try {
      final FirebaseUser _user = await _firebaseService.getCurrentUser();
      assert(_user != null);
      await _collectionReference.document(_user.uid).updateData({
        'username': userModel.username,
        'displayName': userModel.displayName,
      });
    } catch (error) {
      throw 'update username and display name error: $error';
    }
  }

  Future<void> updateIsSetupCompleted(UserModel userModel) async {
    try {
      final FirebaseUser _user = await _firebaseService.getCurrentUser();
      assert(_user != null);
      await _collectionReference.document(_user.uid).updateData({
        'isSetupCompleted': userModel.isSetupCompleted,
      });
    } catch (error) {
      throw 'update is setup completed error: $error';
    }
  }
}
