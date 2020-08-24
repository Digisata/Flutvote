import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:collection/collection.dart';

class MyPostsProviders with ChangeNotifier {
  String _selectedSort = 'Newest', _savedCreatedAt = 'Newest';
  bool _isDefaultFilter = true,
      _isSeeAllDefaultFilter = true,
      _savedIsDefaultFilter = true,
      _isWaitingForGetTotalPosts = false;
  int _totalPosts = 0;
  List<String> _selectedCategoryFilterList = [],
      _savedCategoryFilterList = [],
      _selectedSeeAllCategoryFilterList = [];
  Stream<QuerySnapshot> _myPostSnapshot = Firestore.instance
      .collection('posts')
      .where('uid', isEqualTo: _userData.get('uid'))
      .orderBy('createdAt', descending: true)
      .snapshots();
  static final Box _userData = Hive.box('userData');
  final Function unOrderedDeepEq = DeepCollectionEquality.unordered().equals;
  VoidCallback _onGetTotalPostsCompleted = () {};

  String get selectedSort => _selectedSort;

  String get savedCreatedAt => _savedCreatedAt;

  bool get isDefaultFilter => _isDefaultFilter;

  bool get isSeeAllDefaultFilter => _isSeeAllDefaultFilter;

  bool get isWaitingForGetTotalPosts => _isWaitingForGetTotalPosts;

  int get totalPosts => _totalPosts;

  List<String> get selectedCategoryFilterList => _selectedCategoryFilterList;

  List<String> get savedCategoryFilterList => _savedCategoryFilterList;

  List<String> get selectedSeeAllCategoryFilterList =>
      _selectedSeeAllCategoryFilterList;

  Stream<QuerySnapshot> get myPostSnapshot => _myPostSnapshot;

  set setSelectedCreatedAt(String value) {
    if (_selectedSort != value) {
      _selectedSort = value;
    }
    notifyListeners();
  }

  set isWaitingForGetTotalPosts(bool value) {
    _isWaitingForGetTotalPosts = value;
    notifyListeners();
  }

  set addSelectedCategoryFilterList(String value) {
    _selectedCategoryFilterList.add(value);
  }

  set removeSelectedCategoryFilterList(String value) {
    _selectedCategoryFilterList.removeWhere((element) => element == value);
  }

  set addSelectedSeeAllCategoryFilterList(String value) {
    _selectedSeeAllCategoryFilterList.add(value);
  }

  set removeSelectedSeeAllCategoryFilterList(String value) {
    _selectedSeeAllCategoryFilterList
        .removeWhere((element) => element == value);
  }

  set setOnGetTotalPostsCompleted(VoidCallback value) {
    _onGetTotalPostsCompleted = value;
    notifyListeners();
  }

  void checkMyPostsIsDefaultFilter() {
    if (_selectedSort != 'Newest' || _selectedCategoryFilterList.isNotEmpty) {
      _isDefaultFilter = false;
    } else {
      _isDefaultFilter = true;
    }
    notifyListeners();
  }

  void saveFilterChanges() {
    if (_savedCreatedAt != _selectedSort) {
      _savedCreatedAt = _selectedSort;
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

  void resetMyPostsFilter() {
    _selectedSort = 'Newest';
    _selectedCategoryFilterList = [];
    _isDefaultFilter = true;
    notifyListeners();
  }

  void resetSeeAllCategoryFilter() {
    _selectedSeeAllCategoryFilterList = [];
  }

  void setSelectedSeeAllCategoryFilterList() {
    _selectedSeeAllCategoryFilterList.clear();
    _selectedSeeAllCategoryFilterList.addAll(_selectedCategoryFilterList);
  }

  void setSavedFilter() {
    if (_selectedSort != _savedCreatedAt) {
      _selectedSort = _savedCreatedAt;
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

  void setTotalPosts() async {
    if (_selectedSort == 'Newest') {
      if (_selectedCategoryFilterList.isNotEmpty) {
        Firestore.instance
            .collection('posts')
            .where('uid', isEqualTo: _userData.get('uid'))
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
            .collection('posts')
            .where('uid', isEqualTo: _userData.get('uid'))
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
            .collection('posts')
            .where('uid', isEqualTo: _userData.get('uid'))
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
            .collection('posts')
            .where('uid', isEqualTo: _userData.get('uid'))
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

  void setMyPostSnapshot() {
    if (_savedCreatedAt == 'Newest') {
      if (_savedCategoryFilterList.isNotEmpty) {
        _myPostSnapshot = Firestore.instance
            .collection('posts')
            .where('uid', isEqualTo: _userData.get('uid'))
            .where('categories', arrayContainsAny: _savedCategoryFilterList)
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
      if (_savedCategoryFilterList.isNotEmpty) {
        _myPostSnapshot = Firestore.instance
            .collection('posts')
            .where('uid', isEqualTo: _userData.get('uid'))
            .where('categories', arrayContainsAny: _savedCategoryFilterList)
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
    notifyListeners();
  }
}
