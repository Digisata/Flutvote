import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:collection/collection.dart';

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
  final Function unOrderedDeepEq = DeepCollectionEquality.unordered().equals;

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
  }

  set removeSelectedCategoryFilterList(String value) {
    _selectedCategoryFilterList.removeWhere((element) => element == value);
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
    if (_savedCreatedAt != _selectedCreatedAt) {
      _savedCreatedAt = _selectedCreatedAt;
    }
    if (!unOrderedDeepEq(
        _savedCategoryFilterList, _selectedCategoryFilterList)) {
      _savedCategoryFilterList.clear();
      _savedCategoryFilterList.addAll(_selectedCategoryFilterList);
    }
    if (_savedIsDefaultFilter != _isDefaultFilter) {
      _savedIsDefaultFilter = _isDefaultFilter;
    }
  }

  void resetMyVotedFilter() {
    _selectedCreatedAt = 'Newest';
    _selectedCategoryFilterList = [];
    _isDefaultFilter = true;
    notifyListeners();
  }

  void setSavedFilter() {
    if (_selectedCreatedAt != _savedCreatedAt) {
      _selectedCreatedAt = _savedCreatedAt;
    }
    if (!unOrderedDeepEq(
        _selectedCategoryFilterList, _savedCategoryFilterList)) {
      _selectedCategoryFilterList.clear();
      _selectedCategoryFilterList.addAll(_savedCategoryFilterList);
    }
    if (_isDefaultFilter != _savedIsDefaultFilter) {
      _isDefaultFilter = _savedIsDefaultFilter;
    }
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
      if (_savedCategoryFilterList.isNotEmpty) {
        _myVotedSnapshot = Firestore.instance
            .collection('users')
            .document(_userData.get('uid'))
            .collection('voted')
            .where('categories', arrayContainsAny: _savedCategoryFilterList)
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
      if (_savedCategoryFilterList.isNotEmpty) {
        _myVotedSnapshot = Firestore.instance
            .collection('users')
            .document(_userData.get('uid'))
            .collection('voted')
            .where('categories', arrayContainsAny: _savedCategoryFilterList)
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
    notifyListeners();
  }
}
