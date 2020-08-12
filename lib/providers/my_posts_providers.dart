import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

class MyPostsProviders with ChangeNotifier {
  String _selectedTimeCreated = 'Newest', _savedTimeCreated = 'Newest';
  bool _isDefaultFilter = true, _savedIsDefaultFilter = true;
  int _totalPosts = 0;
  static final Box _userData = Hive.box('userData');
  Stream<QuerySnapshot> _myPostSnapshots = Firestore.instance
      .collection('posts')
      .where('uid', isEqualTo: _userData.get('uid'))
      .orderBy('timeCreated', descending: true)
      .snapshots();

  String get selectedTimeCreated => _selectedTimeCreated;

  String get savedTimeCreated => _savedTimeCreated;

  bool get isDefaultFilter => _isDefaultFilter;

  int get totalPosts => _totalPosts;

  Stream<QuerySnapshot> get myPostSnapshots => _myPostSnapshots;

  set setSelectedTimeCreated(String value) {
    _selectedTimeCreated = value;
    notifyListeners();
  }

  set isDefaultFilter(bool value) {
    _isDefaultFilter = value;
    notifyListeners();
  }

  void checkMyPostsIsDefaultFilter() {
    if (_selectedTimeCreated != 'Newest') {
      _isDefaultFilter = false;
    } else {
      _isDefaultFilter = true;
    }
    notifyListeners();
  }

  void saveFilterChanges() {
    _savedTimeCreated = _selectedTimeCreated;
    _savedIsDefaultFilter = _isDefaultFilter;
    notifyListeners();
  }

  void resetMyPostsFilter() {
    _selectedTimeCreated = 'Newest';
    _isDefaultFilter = true;
    notifyListeners();
  }

  void setSavedFilter() {
    _selectedTimeCreated = _savedTimeCreated;
    _isDefaultFilter = _savedIsDefaultFilter;
  }

  void setTotalPosts() {
    if (_selectedTimeCreated == 'Newest') {
      Firestore.instance
          .collection('posts')
          .where('uid', isEqualTo: _userData.get('uid'))
          .orderBy('timeCreated', descending: true)
          .getDocuments()
          .then(
            (value) => _totalPosts = value.documents.length,
          );
    } else {
      Firestore.instance
          .collection('posts')
          .where('uid', isEqualTo: _userData.get('uid'))
          .orderBy('timeCreated')
          .getDocuments()
          .then(
            (value) => _totalPosts = value.documents.length,
          );
    }
    notifyListeners();
  }

  void setMyPostSnapshots() {
    if (_selectedTimeCreated == 'Newest') {
      _myPostSnapshots = Firestore.instance
          .collection('posts')
          .where('uid', isEqualTo: _userData.get('uid'))
          .orderBy('timeCreated', descending: true)
          .snapshots();
    } else {
      _myPostSnapshots = Firestore.instance
          .collection('posts')
          .where('uid', isEqualTo: _userData.get('uid'))
          .orderBy('timeCreated')
          .snapshots();
    }
    notifyListeners();
  }
}
