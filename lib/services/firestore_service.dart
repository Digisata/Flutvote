import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutvote/model/models.dart';
import 'package:flutvote/providers/providers.dart';
import 'package:flutvote/services/services.dart';

class FirestoreService {
  final CollectionReference _usersCollectionReference =
      Firestore.instance.collection('users');
  final CollectionReference _postsCollectionReference =
      Firestore.instance.collection('posts');
  final FirebaseService _firebaseService = FirebaseService();

  Future<bool> isUsernameExist(String username) async {
    try {
      final QuerySnapshot _querySnapshot = await _usersCollectionReference
          .where('username'.toLowerCase(), isEqualTo: username.toLowerCase())
          .limit(1)
          .getDocuments();
      assert(_querySnapshot != null);
      final List<DocumentSnapshot> _documents = _querySnapshot.documents;
      return _documents.length == 1;
    } catch (error) {
      throw 'is username exist error: $error';
    }
  }

  Future<bool> isAlreadyRegistered() async {
    try {
      final FirebaseUser _user = await _firebaseService.getCurrentUser();
      assert(_user != null);
      final DocumentSnapshot _documentSnapshot =
          await _usersCollectionReference.document(_user.uid).get();
      return _documentSnapshot.exists;
    } catch (error) {
      throw 'is already registered error: $error';
    }
  }

  Future<bool> isPostOwner(DocumentSnapshot documentSnapshot) async {
    try {
      final FirebaseUser _user = await _firebaseService.getCurrentUser();
      assert(_user != null);
      final PostModel _postModel = PostModel.fromMap(documentSnapshot.data);
      assert(_postModel != null);
      return _postModel.uid == _user.uid;
    } catch (error) {
      throw 'is post owener error: $error';
    }
  }

  Future<bool> isAlreadyVoted(DocumentSnapshot documentSnapshot) async {
    try {
      final CollectionReference _subCollectionReference =
          _postsCollectionReference
              .document(documentSnapshot.documentID)
              .collection('voter');
      final FirebaseUser _user = await _firebaseService.getCurrentUser();
      assert(_user != null);
      final DocumentSnapshot _documentSnapshot =
          await _subCollectionReference.document(_user.uid).get();
      return _documentSnapshot.exists;
    } catch (error) {
      throw 'is already voted error: $error';
    }
  }

  Future<void> fetchUserData() async {
    try {
      final FirebaseUser _user = await _firebaseService.getCurrentUser();
      assert(_user != null);
      final DocumentSnapshot _document =
          await _usersCollectionReference.document(_user.uid).get();
      assert(_document.exists);
      AppProviders.setUserModel = UserModel.fromMap(_document.data);
    } catch (error) {
      throw 'get data error: $error';
    }
  }

  Future<void> setUserData(UserModel userModel) async {
    try {
      final FirebaseUser _user = await _firebaseService.getCurrentUser();
      assert(_user != null);
      await _usersCollectionReference.document(_user.uid).setData(
            userModel.toMap(),
            merge: true,
          );
    } catch (error) {
      throw 'set data error: $error';
    }
  }

  Future<void> setVoterData(DocumentSnapshot documentSnapshot) async {
    try {
      final CollectionReference _voterCollectionReference =
          _postsCollectionReference
              .document(documentSnapshot.documentID)
              .collection('voter');
      final FirebaseUser _user = await _firebaseService.getCurrentUser();
      assert(_user != null);
      await _voterCollectionReference.document(_user.uid).setData(
            AppProviders.userModel.toMap(),
            merge: true,
          );
    } catch (error) {
      throw 'set voter data error: $error';
    }
  }

  Future<void> updatePhotoUrl(String photoUrl) async {
    try {
      final FirebaseUser _user = await _firebaseService.getCurrentUser();
      assert(_user != null);
      await _usersCollectionReference.document(_user.uid).updateData(
        {
          'photoUrl': photoUrl,
        },
      );
    } catch (error) {
      throw 'update photo url error: $error';
    }
  }

  Future<void> updateDisplayName(String displayName) async {
    try {
      final FirebaseUser _user = await _firebaseService.getCurrentUser();
      assert(_user != null);
      await _usersCollectionReference.document(_user.uid).updateData(
        {
          'displayName': displayName,
        },
      );
    } catch (error) {
      throw 'update display name error: $error';
    }
  }

  Future<void> updateUsername(String username) async {
    try {
      final FirebaseUser _user = await _firebaseService.getCurrentUser();
      assert(_user != null);
      await _usersCollectionReference.document(_user.uid).updateData(
        {
          'username': username,
        },
      );
    } catch (error) {
      throw 'update username error: $error';
    }
  }

  Future<void> updateIsSetupCompleted(bool isSetupCompleted) async {
    try {
      final FirebaseUser _user = await _firebaseService.getCurrentUser();
      assert(_user != null);
      await _usersCollectionReference.document(_user.uid).updateData(
        {
          'isSetupCompleted': isSetupCompleted,
        },
      );
    } catch (error) {
      throw 'update is setup completed error: $error';
    }
  }

  Future<void> updateUsersPost() async {
    final FirebaseUser _user = await _firebaseService.getCurrentUser();
    assert(_user != null);
    final UserModel _userModel = AppProviders.userModel;
    assert(_userModel != null);
    final QuerySnapshot _querySnapshot = await _postsCollectionReference
        .where('uid', isEqualTo: _user.uid)
        .getDocuments();
    assert(_querySnapshot != null);
    final List<DocumentSnapshot> _documents = _querySnapshot.documents;
    if (_documents.isNotEmpty) {
      _documents.forEach(
        (documentSnapshot) {
          documentSnapshot.reference.updateData(
            {
              'photoUrl': _userModel.photoUrl,
              'displayName': _userModel.displayName,
              'username': _userModel.username,
            },
          );
        },
      );
    }
  }

  Future<void> updatePostVoter() async {
    final FirebaseUser _user = await _firebaseService.getCurrentUser();
    assert(_user != null);
    final UserModel _userModel = AppProviders.userModel;
    assert(_userModel != null);
    final QuerySnapshot _querySnapshot =
        await _postsCollectionReference.getDocuments();
    assert(_querySnapshot != null);
    final List<DocumentSnapshot> _documents = _querySnapshot.documents;
    if (_documents.isNotEmpty) {
      _documents.forEach(
        (documentSnapshot) {
          documentSnapshot.reference
              .collection('voter')
              .document(_user.uid)
              .updateData(
            {
              'photoUrl': _userModel.photoUrl,
              'displayName': _userModel.displayName,
              'username': _userModel.username,
            },
          );
        },
      );
    }
  }

  // TODO FIX UPDATE VOTE DATA
  Future<void> updateVoteData(
    DocumentSnapshot documentSnapshot,
    String key,
    int index,
  ) async {
    try {
      await Firestore.instance.runTransaction(
        (transaction) async {
          final DocumentSnapshot _freshSnapshot =
              await transaction.get(documentSnapshot.reference);
          assert(_freshSnapshot.exists);
          final PostModel _postModel = PostModel.fromMap(_freshSnapshot.data);
          assert(_postModel != null);
          await transaction.update(
            _freshSnapshot.reference,
            {
              'totalVotes': _postModel.totalVotes + 1,
              'options': [
                {
                  'option': key,
                  'votes': _postModel.options[index]
                          .toMap()
                          .values
                          .elementAt(index) +
                      1,
                }
              ]
            },
          );
        },
      );
    } catch (error) {
      throw 'update vote data error: $error';
    }
  }
}
