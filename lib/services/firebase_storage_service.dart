import 'dart:io';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutvote/services/services.dart';

class FirebaseStorageService {
  final FirebaseService _firebaseService = FirebaseService();

  Future<dynamic> getPhotoProfileUrl(File image, String imageName) async {
    try {
      final FirebaseUser _user = await _firebaseService.getCurrentUser();
      assert(_user != null);
      final StorageReference _storageReference = FirebaseStorage.instance
          .ref()
          .child('photoProfiles')
          .child(_user.uid)
          .child(imageName);
      assert(_storageReference != null);
      final StorageUploadTask _storageUploadTask =
          _storageReference.putFile(image);
      final StorageTaskSnapshot _storageTaskSnapshot =
          await _storageUploadTask.onComplete;
      return await _storageTaskSnapshot.ref.getDownloadURL();
    } catch (error) {
      throw 'upload photo profile error: $error';
    }
  }
}
