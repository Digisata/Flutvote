import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

class MyVotedProviders with ChangeNotifier {
  String _selectedCreatedAt = 'Newest', _savedCreatedAt = 'Newest';
  bool _isDefaultFilter = true, _savedIsDefaultFilter = true;
  int _totalPosts = 0;
  static final Box _userData = Hive.box('userData');

  String get selectedCreatedAt => _selectedCreatedAt;

  String get savedCreatedAt => _savedCreatedAt;

  bool get isDefaultFilter => _isDefaultFilter;

  int get totalPosts => _totalPosts;

  Stream<QuerySnapshot> getMyVotedSnapshots() {
    if (_savedCreatedAt == 'Newest') {
      return Firestore.instance
          .collection('users')
          .document(_userData.get('uid'))
          .collection('voted')
          .orderBy('createdAt', descending: true)
          .snapshots();
    } else {
      return Firestore.instance
          .collection('users')
          .document(_userData.get('uid'))
          .collection('voted')
          .orderBy('createdAt')
          .snapshots();
    }
  }

  set setSelectedCreatedAt(String value) {
    _selectedCreatedAt = value;
    notifyListeners();
  }

  void checkMyVotedIsDefaultFilter() {
    if (_selectedCreatedAt != 'Newest') {
      _isDefaultFilter = false;
    } else {
      _isDefaultFilter = true;
    }
    notifyListeners();
  }

  void saveFilterChanges() {
    _savedCreatedAt = _selectedCreatedAt;
    _savedIsDefaultFilter = _isDefaultFilter;
    notifyListeners();
  }

  void resetMyVotedFilter() {
    _selectedCreatedAt = 'Newest';
    _isDefaultFilter = true;
    notifyListeners();
  }

  void setSavedFilter() {
    _selectedCreatedAt = _savedCreatedAt;
    _isDefaultFilter = _savedIsDefaultFilter;
  }

  void setTotalVoted() {
    if (_selectedCreatedAt == 'Newest') {
      Firestore.instance
          .collection('users')
          .document(_userData.get('uid'))
          .collection('voted')
          .orderBy('createdAt', descending: true)
          .getDocuments()
          .then(
            (value) => _totalPosts = value.documents.length,
          );
    } else {
      Firestore.instance
          .collection('users')
          .document(_userData.get('uid'))
          .collection('voted')
          .orderBy('createdAt')
          .getDocuments()
          .then(
            (value) => _totalPosts = value.documents.length,
          );
    }
    notifyListeners();
  }
}
