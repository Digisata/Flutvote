import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:hive/hive.dart';
import 'package:collection/collection.dart';

class MyVotedProviders with ChangeNotifier {
  String _selectedSort = 'Newest', _savedSort = 'Newest';
  bool _isDefaultFilter = true,
      _savedIsDefaultFilter = true,
      _isWaitingForGetTotalPosts = false;
  int _totalPosts = 0;
  List<String> _categoryFilterList = [
        'Fashion',
        'Food',
        'Health',
        'Sport',
        'Travel',
      ],
      _selectedCategoryFilterList = [],
      _savedCategoryFilterList = [],
      _selectedSeeAllCategoryFilterList = [];
  Stream<QuerySnapshot> _myVotedSnapshot = Firestore.instance
      .collection('users')
      .document(_userData.get('uid'))
      .collection('voted')
      .orderBy('createdAt', descending: true)
      .snapshots();
  static final Box _userData = Hive.box('userData');
  final Function unOrderedDeepEq = DeepCollectionEquality.unordered().equals;
  VoidCallback _onGetTotalPostsCompleted = () {};

  String get selectedSort => _selectedSort;

  String get savedSort => _savedSort;

  bool get isDefaultFilter => _isDefaultFilter;

  bool get isWaitingForGetTotalPosts => _isWaitingForGetTotalPosts;

  int get totalPosts => _totalPosts;

  List<String> get categoryFilterList => _categoryFilterList;

  List<String> get selectedCategoryFilterList => _selectedCategoryFilterList;

  List<String> get savedCategoryFilterList => _savedCategoryFilterList;

  List<String> get selectedSeeAllCategoryFilterList =>
      _selectedSeeAllCategoryFilterList;

  Stream<QuerySnapshot> get myVotedSnapshot => _myVotedSnapshot;

  set setSelectedSort(String value) {
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

  set categoryFilterList(List<String> value) {
    _categoryFilterList.clear();
    _categoryFilterList.addAll(value);
  }

  set selectedCategoryFilterList(List<String> value) {
    _selectedCategoryFilterList.clear();
    _selectedCategoryFilterList.addAll(value);
  }

  void checkMyVotedIsDefaultFilter() {
    if (_selectedSort != 'Newest' || _selectedCategoryFilterList.isNotEmpty) {
      _isDefaultFilter = false;
    } else {
      _isDefaultFilter = true;
    }
    notifyListeners();
  }

  void saveFilterChanges() {
    if (_savedSort != _selectedSort) {
      _savedSort = _selectedSort;
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
    if (_selectedSort != _savedSort) {
      _selectedSort = _savedSort;
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
    if (_selectedSort == 'Newest') {
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
    if (_savedSort == 'Newest') {
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
