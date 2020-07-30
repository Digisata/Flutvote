import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutvote/model/models.dart';
import 'package:flutvote/providers/providers.dart';
import 'package:flutvote/services/services.dart';

class FirestoreService {
  final CollectionReference _collectionReference =
      Firestore.instance.collection('users');
  final FirebaseService _firebaseService = FirebaseService();

  Future<bool> isUsernameExist(String username) async {
    try {
      final QuerySnapshot _querySnapshot = await _collectionReference
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
          await _collectionReference.document(_user.uid).get();
      assert(_documentSnapshot != null);
      return _documentSnapshot.exists;
    } catch (error) {
      throw 'is user exist error: $error';
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
      final CollectionReference _subCollectionReference = Firestore.instance
          .collection('posts')
          .document(documentSnapshot.documentID)
          .collection('voter');
      final FirebaseUser _user = await _firebaseService.getCurrentUser();
      assert(_user != null);
      final DocumentSnapshot _documentSnapshot =
          await _subCollectionReference.document(_user.uid).get();
      assert(_documentSnapshot != null);
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

  Future<void> setVoterData(DocumentSnapshot documentSnapshot) async {
    try {
      final CollectionReference _subCollectionReference = Firestore.instance
          .collection('posts')
          .document(documentSnapshot.documentID)
          .collection('voter');
      final FirebaseUser _user = await _firebaseService.getCurrentUser();
      assert(_user != null);
      await _subCollectionReference.document(_user.uid).setData(
            AppProviders.userModel.toMap(),
            merge: true,
          );
    } catch (error) {
      throw 'set voter data error: $error';
    }
  }

  Future<void> updateUsernameAndDisplayName(UserModel userModel) async {
    try {
      final FirebaseUser _user = await _firebaseService.getCurrentUser();
      assert(_user != null);
      await _collectionReference.document(_user.uid).updateData(
        {
          'username': userModel.username,
          'displayName': userModel.displayName,
        },
      );
    } catch (error) {
      throw 'update username and display name error: $error';
    }
  }

  Future<void> updateIsSetupCompleted(UserModel userModel) async {
    try {
      final FirebaseUser _user = await _firebaseService.getCurrentUser();
      assert(_user != null);
      await _collectionReference.document(_user.uid).updateData(
        {
          'isSetupCompleted': userModel.isSetupCompleted,
        },
      );
    } catch (error) {
      throw 'update is setup completed error: $error';
    }
  }

  Future<void> updateVoteData(
    DocumentSnapshot documentSnapshot,
    String key,
    int index,
  ) async {
    try {
      Firestore.instance.runTransaction(
        (transaction) async {
          final DocumentSnapshot _freshSnapshot =
              await transaction.get(documentSnapshot.reference);
          assert(_freshSnapshot != null);
          final PostModel _postModel = PostModel.fromMap(_freshSnapshot.data);
          assert(_postModel != null);
          await transaction.update(
            _freshSnapshot.reference,
            {
              'totalVotes': _postModel.totalVotes + 1,
              /* 'detailVotes': {
                key: _postModel.detailVotes.toMap().values.elementAt(index) + 1,
              }, */
            },
          );
        },
      );
    } catch (error) {
      throw 'update vote data error: $error';
    }
  }
}
