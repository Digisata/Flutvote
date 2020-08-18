import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';

class MyVotedProviders with ChangeNotifier {
  String _selectedCreatedAt = 'Newest', _savedCreatedAt = 'Newest';
  bool _isDefaultFilter = true, _savedIsDefaultFilter = true;
  int _totalPosts = 0;
  List<String> _selectedCategoryFilterList = [], _savedCategoryFilterList = [];
  Stream<QuerySnapshot> _myVotedSnapshot = Firestore.instance
      .collection('users')
      .document(_userData.get('uid'))
      .collection('voted')
      .orderBy('createdAt', descending: true)
      .snapshots();
  static final Box _userData = Hive.box('userData');

  String get selectedCreatedAt => _selectedCreatedAt;

  String get savedCreatedAt => _savedCreatedAt;

  bool get isDefaultFilter => _isDefaultFilter;

  int get totalPosts => _totalPosts;

  List<String> get selectedCategoryFilterList => _selectedCategoryFilterList;

  List<String> get savedCategoryFilterList => _savedCategoryFilterList;

  Stream<QuerySnapshot> get myVotedSnapshot => _myVotedSnapshot;

  set setSelectedCreatedAt(String value) {
    _selectedCreatedAt = value;
    notifyListeners();
  }

  set addSelectedCategoryFilterList(String value) {
    _selectedCategoryFilterList.add(value);
    notifyListeners();
  }

  set removeSelectedCategoryFilterList(String value) {
    _selectedCategoryFilterList.removeWhere((element) => element == value);
    notifyListeners();
  }

  void checkMyVotedIsDefaultFilter() {
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

  void resetMyVotedFilter() {
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

  Future<void> setTotalVoted() async {
    if (_selectedCreatedAt == 'Newest') {
      if (_selectedCategoryFilterList.isNotEmpty) {
        await Firestore.instance
            .collection('users')
            .document(_userData.get('uid'))
            .collection('voted')
            .where('categories', arrayContainsAny: _selectedCategoryFilterList)
            .orderBy('createdAt', descending: true)
            .getDocuments()
            .then(
              (value) => _totalPosts = value.documents.length,
            );
      } else {
        await Firestore.instance
            .collection('users')
            .document(_userData.get('uid'))
            .collection('voted')
            .orderBy('createdAt', descending: true)
            .getDocuments()
            .then(
              (value) => _totalPosts = value.documents.length,
            );
      }
    } else {
      if (_selectedCategoryFilterList.isNotEmpty) {
        await Firestore.instance
            .collection('users')
            .document(_userData.get('uid'))
            .collection('voted')
            .where('categories', arrayContainsAny: _selectedCategoryFilterList)
            .orderBy('createdAt')
            .getDocuments()
            .then(
              (value) => _totalPosts = value.documents.length,
            );
      } else {
        await Firestore.instance
            .collection('users')
            .document(_userData.get('uid'))
            .collection('voted')
            .orderBy('createdAt')
            .getDocuments()
            .then(
              (value) => _totalPosts = value.documents.length,
            );
      }
    }
    notifyListeners();
  }

  void setMyVotedSnapshot() {
    if (_savedCreatedAt == 'Newest') {
      if (_selectedCategoryFilterList.isNotEmpty) {
        _myVotedSnapshot = Firestore.instance
            .collection('users')
            .document(_userData.get('uid'))
            .collection('voted')
            .where('categories', arrayContainsAny: _selectedCategoryFilterList)
            .orderBy('createdAt', descending: true)
            .snapshots();
      } else {
        _myVotedSnapshot = Firestore.instance
            .collection('users')
            .document(_userData.get('uid'))
            .collection('voted')
            .orderBy('createdAt', descending: true)
            .snapshots();
      }
    } else {
      if (_selectedCategoryFilterList.isNotEmpty) {
        _myVotedSnapshot = Firestore.instance
            .collection('users')
            .document(_userData.get('uid'))
            .collection('voted')
            .where('categories', arrayContainsAny: _selectedCategoryFilterList)
            .orderBy('createdAt')
            .snapshots();
      } else {
        _myVotedSnapshot = Firestore.instance
            .collection('users')
            .document(_userData.get('uid'))
            .collection('voted')
            .orderBy('createdAt')
            .snapshots();
      }
    }
  }
}
