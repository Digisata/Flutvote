import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class HomeProviders with ChangeNotifier {
  String _searchKeyword = '';
  List<String> _selectedCategoryList = [];
  List<int> _selectedCategoryIndexList = [];

  String get searchKeyword => _searchKeyword;

  List<String> get selectedCategoryList => _selectedCategoryList;

  List<int> get selectedCategoryIndexList => _selectedCategoryIndexList;

  Stream<QuerySnapshot> getPostSnapshots() {
    if (_selectedCategoryList.length == 0) {
      return Firestore.instance
          .collection('posts')
          .orderBy('createdAt', descending: true)
          .snapshots();
    } else {
      return Firestore.instance
          .collection('posts')
          .where('categories', arrayContainsAny: _selectedCategoryList)
          .orderBy('createdAt', descending: true)
          .snapshots();
    }
  }

  set searchKeyword(String value) {
    _searchKeyword = value;
    notifyListeners();
  }

  set addSelectedCategoryList(String value) {
    _selectedCategoryList.add(value);
    notifyListeners();
  }

  set addSelectedCategoryIndexList(int value) {
    _selectedCategoryIndexList.add(value);
    notifyListeners();
  }

  set deleteSelectedCategoryList(String value) {
    _selectedCategoryList.removeWhere((element) => element == value);
    notifyListeners();
  }

  set deleteSelectedCategoryIndexList(int value) {
    _selectedCategoryIndexList.removeWhere((element) => element == value);
    notifyListeners();
  }

  void resetCategoryFilter() {
    _selectedCategoryList = [];
    _selectedCategoryIndexList = [];
    notifyListeners();
  }
}
