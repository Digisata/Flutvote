import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

class MyPostsProviders with ChangeNotifier {
  String _selectedCreatedAt = 'Newest', _savedCreatedAt = 'Newest';
  bool _isDefaultFilter = true, _savedIsDefaultFilter = true;
  int _totalPosts = 0;
  List<String> _selectedCategoryFilterList = [], _savedCategoryFilterList = [];
  Stream<QuerySnapshot> _myPostSnapshot = Firestore.instance
      .collection('posts')
      .where('uid', isEqualTo: _userData.get('uid'))
      .orderBy('createdAt', descending: true)
      .snapshots();

  static final Box _userData = Hive.box('userData');

  String get selectedCreatedAt => _selectedCreatedAt;

  String get savedCreatedAt => _savedCreatedAt;

  bool get isDefaultFilter => _isDefaultFilter;

  int get totalPosts => _totalPosts;

  List<String> get selectedCategoryFilterList => _selectedCategoryFilterList;

  List<String> get savedCategoryFilterList => _savedCategoryFilterList;

  Stream<QuerySnapshot> get myPostSnapshot => _myPostSnapshot;

  set setSelectedCreatedAt(String value) {
    _selectedCreatedAt = value;
    notifyListeners();
  }

  set addSelectedCategoryFilterList(String value) {
    // TODO FIX THIS ASSIGN LIST VALUE
    _selectedCategoryFilterList.add(value);
    notifyListeners();
  }

  set removeSelectedCategoryFilterList(String value) {
    _selectedCategoryFilterList.removeWhere((element) => element == value);
    notifyListeners();
  }

  void checkMyPostsIsDefaultFilter() {
    if (_selectedCreatedAt != 'Newest' ||
        _selectedCategoryFilterList.isNotEmpty) {
      _isDefaultFilter = false;
    } else {
      _isDefaultFilter = true;
    }
    notifyListeners();
  }

  void saveFilterChanges() {
    _savedCreatedAt = _selectedCreatedAt;
    _savedCategoryFilterList = _selectedCategoryFilterList;
    _savedIsDefaultFilter = _isDefaultFilter;
    notifyListeners();
  }

  void resetMyPostsFilter() {
    _selectedCreatedAt = 'Newest';
    _selectedCategoryFilterList = [];
    _isDefaultFilter = true;
    notifyListeners();
  }

  void setSavedFilter() {
    _selectedCreatedAt = _savedCreatedAt;
    _selectedCategoryFilterList = _savedCategoryFilterList;
    _isDefaultFilter = _savedIsDefaultFilter;
  }

  Future<void> setTotalPosts() async {
    if (_selectedCreatedAt == 'Newest') {
      if (_selectedCategoryFilterList.isNotEmpty) {
        await Firestore.instance
            .collection('posts')
            .where('uid', isEqualTo: _userData.get('uid'))
            .where('categories', arrayContainsAny: _selectedCategoryFilterList)
            .orderBy('createdAt', descending: true)
            .getDocuments()
            .then(
              (value) => _totalPosts = value.documents.length,
            );
      } else {
        await Firestore.instance
            .collection('posts')
            .where('uid', isEqualTo: _userData.get('uid'))
            .orderBy('createdAt', descending: true)
            .getDocuments()
            .then(
              (value) => _totalPosts = value.documents.length,
            );
      }
    } else {
      if (_selectedCategoryFilterList.isNotEmpty) {
        await Firestore.instance
            .collection('posts')
            .where('uid', isEqualTo: _userData.get('uid'))
            .where('categories', arrayContainsAny: _selectedCategoryFilterList)
            .orderBy('createdAt')
            .getDocuments()
            .then(
              (value) => _totalPosts = value.documents.length,
            );
      } else {
        await Firestore.instance
            .collection('posts')
            .where('uid', isEqualTo: _userData.get('uid'))
            .orderBy('createdAt')
            .getDocuments()
            .then(
              (value) => _totalPosts = value.documents.length,
            );
      }
    }
    notifyListeners();
  }

  void setMyPostSnapshot() {
    if (_savedCreatedAt == 'Newest') {
      if (_selectedCategoryFilterList.isNotEmpty) {
        _myPostSnapshot = Firestore.instance
            .collection('posts')
            .where('uid', isEqualTo: _userData.get('uid'))
            .where('categories', arrayContainsAny: _selectedCategoryFilterList)
            .orderBy('createdAt', descending: true)
            .snapshots();
      } else {
        _myPostSnapshot = Firestore.instance
            .collection('posts')
            .where('uid', isEqualTo: _userData.get('uid'))
            .orderBy('createdAt', descending: true)
            .snapshots();
      }
    } else {
      if (_selectedCategoryFilterList.isNotEmpty) {
        _myPostSnapshot = Firestore.instance
            .collection('posts')
            .where('uid', isEqualTo: _userData.get('uid'))
            .where('categories', arrayContainsAny: _selectedCategoryFilterList)
            .orderBy('createdAt')
            .snapshots();
      } else {
        _myPostSnapshot = Firestore.instance
            .collection('posts')
            .where('uid', isEqualTo: _userData.get('uid'))
            .orderBy('createdAt')
            .snapshots();
      }
    }
  }
}
