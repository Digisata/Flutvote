import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:collection/collection.dart';

class MyVotedProviders with ChangeNotifier {
  String _selectedCreatedAt = 'Newest', _savedCreatedAt = 'Newest';
  bool _isDefaultFilter = true,
      _savedIsDefaultFilter = true,
      _isWaitingForGetTotalPosts = false;
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
  VoidCallback _onGetTotalPostsCompleted = () {};

  String get selectedCreatedAt => _selectedCreatedAt;

  String get savedCreatedAt => _savedCreatedAt;

  bool get isDefaultFilter => _isDefaultFilter;

  bool get isWaitingForGetTotalPosts => _isWaitingForGetTotalPosts;

  int get totalPosts => _totalPosts;

  List<String> get selectedCategoryFilterList => _selectedCategoryFilterList;

  List<String> get savedCategoryFilterList => _savedCategoryFilterList;

  Stream<QuerySnapshot> get myVotedSnapshot => _myVotedSnapshot;

  set isWaitingForGetTotalPosts(bool value) {
    _isWaitingForGetTotalPosts = value;
    notifyListeners();
  }

  set setSelectedCreatedAt(String value) {
    if (_selectedCreatedAt != value) {
      _selectedCreatedAt = value;
    }
    notifyListeners();
  }

  set addSelectedCategoryFilterList(String value) {
    _selectedCategoryFilterList.add(value);
  }

  set removeSelectedCategoryFilterList(String value) {
    _selectedCategoryFilterList.removeWhere((element) => element == value);
  }

  set setOnGetTotalPostsCompleted(VoidCallback value) {
    _onGetTotalPostsCompleted = value;
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

  void setTotalVoted() {
    if (_selectedCreatedAt == 'Newest') {
      if (_selectedCategoryFilterList.isNotEmpty) {
        Firestore.instance
            .collection('users')
            .document(_userData.get('uid'))
            .collection('voted')
            .where('categories', arrayContainsAny: _selectedCategoryFilterList)
            .orderBy('createdAt', descending: true)
            .getDocuments()
            .then(
          (value) {
            _totalPosts = value.documents.length;
            _isWaitingForGetTotalPosts = false;
            _onGetTotalPostsCompleted();
            notifyListeners();
          },
        );
      } else {
        Firestore.instance
            .collection('users')
            .document(_userData.get('uid'))
            .collection('voted')
            .orderBy('createdAt', descending: true)
            .getDocuments()
            .then(
          (value) {
            _totalPosts = value.documents.length;
            _isWaitingForGetTotalPosts = false;
            _onGetTotalPostsCompleted();
            notifyListeners();
          },
        );
      }
    } else {
      if (_selectedCategoryFilterList.isNotEmpty) {
        Firestore.instance
            .collection('users')
            .document(_userData.get('uid'))
            .collection('voted')
            .where('categories', arrayContainsAny: _selectedCategoryFilterList)
            .orderBy('createdAt')
            .getDocuments()
            .then(
          (value) {
            _totalPosts = value.documents.length;
            _isWaitingForGetTotalPosts = false;
            _onGetTotalPostsCompleted();
            notifyListeners();
          },
        );
      } else {
        Firestore.instance
            .collection('users')
            .document(_userData.get('uid'))
            .collection('voted')
            .orderBy('createdAt')
            .getDocuments()
            .then(
          (value) {
            _totalPosts = value.documents.length;
            _isWaitingForGetTotalPosts = false;
            _onGetTotalPostsCompleted();
            notifyListeners();
          },
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
