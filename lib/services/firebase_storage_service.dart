import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';

class FirebaseStorageService {
  Future<dynamic> uploadPhotoProfile(File image, String imageName) async {
    try {
      final StorageReference _storageReference = FirebaseStorage.instance
          .ref()
          .child('photoProfiles')
          .child(imageName);
      assert(_storageReference != null);
      final StorageUploadTask _storageUploadTask =
          _storageReference.putFile(image);
      final StorageTaskSnapshot _storageTaskSnapshot =
          await _storageUploadTask.onComplete;
      return _storageTaskSnapshot.ref.getDownloadURL();
    } catch (error) {
      throw 'upload photo profile error: $error';
    }
  }
}
