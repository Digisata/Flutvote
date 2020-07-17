import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutvote/model/models.dart';
import 'package:flutvote/services/services.dart';

class FirestoreService {
  final CollectionReference _userCollectionReference =
      Firestore.instance.collection('users');
  final FirebaseService _firebaseService = FirebaseService();    

  Future<void> createUser(UserModel userModel) async {
    try {
      final FirebaseUser _firebaseUser = await _firebaseService.getCurrentUser();
      assert(_firebaseUser != null);
      await _userCollectionReference
          .document(_firebaseUser.uid)
          .setData(userModel.toJson());
    } catch (error) {
      throw 'create user error: $error';
    }
  }
}
