import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class HomeProviders with ChangeNotifier {
  String _searchKeyword = '';
  bool _isDefaultFilter = true;
  int _totalPosts = 0;
  List<String> _selectedCategoryList = [];
  Stream<QuerySnapshot> _postSnapshots = Firestore.instance
      .collection('posts')
      .orderBy('createdAt', descending: true)
      .snapshots();

  String get searchKeyword => _searchKeyword;

  bool get isDefaultFilter => _isDefaultFilter;

  int get totalPosts => _totalPosts;

  List<String> get selectedCategoryList => _selectedCategoryList;

  Stream<QuerySnapshot> get postSnapshots => _postSnapshots;

  set searchKeyword(String value) {
    _searchKeyword = value;
    notifyListeners();
  }

  set addSelectedCategoryList(String value) {
    _selectedCategoryList.add(value);
    notifyListeners();
  }

  set removeSelectedCategoryList(String value) {
    _selectedCategoryList.removeWhere((element) => element == value);
    notifyListeners();
  }

  void checkIsDefaultFilter() {
    if (_selectedCategoryList.isNotEmpty) {
      _isDefaultFilter = false;
    } else {
      _isDefaultFilter = true;
    }
    notifyListeners();
  }

  void resetCategoryFilter() {
    _selectedCategoryList = [];
    notifyListeners();
  }

  Future<void> setTotalPosts() async {
    if (_selectedCategoryList.isEmpty) {
      await Firestore.instance
          .collection('posts')
          .orderBy('createdAt', descending: true)
          .getDocuments()
          .then(
            (value) => _totalPosts = value.documents.length,
          );
    } else {
      await Firestore.instance
          .collection('posts')
          .where('categories', arrayContainsAny: _selectedCategoryList)
          .orderBy('createdAt', descending: true)
          .getDocuments()
          .then(
            (value) => _totalPosts = value.documents.length,
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
  }
}
