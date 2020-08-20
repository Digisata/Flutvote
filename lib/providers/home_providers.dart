import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class HomeProviders with ChangeNotifier {
  String _searchKeyword = '';
  bool _isDefaultFilter = true, _isWaitingForGetTotalPosts = false;
  int _totalPosts = 0;
  List<String> _selectedCategoryList = [];
  Stream<QuerySnapshot> _postSnapshots = Firestore.instance
      .collection('posts')
      .orderBy('createdAt', descending: true)
      .snapshots();

  String get searchKeyword => _searchKeyword;

  bool get isDefaultFilter => _isDefaultFilter;

  bool get isWaitingForGetTotalPosts => _isWaitingForGetTotalPosts;

  int get totalPosts => _totalPosts;

  List<String> get selectedCategoryList => _selectedCategoryList;

  Stream<QuerySnapshot> get postSnapshots => _postSnapshots;

  set searchKeyword(String value) {
    _searchKeyword = value;
    notifyListeners();
  }

  set isWaitingForGetTotalPosts(bool value) {
    _isWaitingForGetTotalPosts = value;
    notifyListeners();
  }

  set addSelectedCategoryList(String value) {
    _selectedCategoryList.add(value);
  }

  set removeSelectedCategoryList(String value) {
    _selectedCategoryList.removeWhere((element) => element == value);
  }

  void checkIsDefaultFilter() {
    if (_selectedCategoryList.isNotEmpty) {
      _isDefaultFilter = false;
    } else {
      _isDefaultFilter = true;
    }
  }

  void resetPostsFilter() {
    _selectedCategoryList = [];
    _isDefaultFilter = true;
  }

  void setTotalPosts() {
    if (_selectedCategoryList.isEmpty) {
      Firestore.instance
          .collection('posts')
          .orderBy('createdAt', descending: true)
          .getDocuments()
          .then(
        (value) {
          _totalPosts = value.documents.length;
          _isWaitingForGetTotalPosts = false;
          notifyListeners();
        },
      );
    } else {
      Firestore.instance
          .collection('posts')
          .where('categories', arrayContainsAny: _selectedCategoryList)
          .orderBy('createdAt', descending: true)
          .getDocuments()
          .then(
        (value) {
          _totalPosts = value.documents.length;
          _isWaitingForGetTotalPosts = false;
          notifyListeners();
        },
      );
    }
    notifyListeners();
  }

  void setPostSnapshots() {
    if (_selectedCategoryList.isEmpty) {
      _postSnapshots = Firestore.instance
          .collection('posts')
          .orderBy('createdAt', descending: true)
          .snapshots();
    } else {
      _postSnapshots = Firestore.instance
          .collection('posts')
          .where('categories', arrayContainsAny: _selectedCategoryList)
          .orderBy('createdAt', descending: true)
          .snapshots();
    }
    notifyListeners();
  }
}
