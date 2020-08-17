import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';

class HomeProviders with ChangeNotifier {
  String _searchKeyword = '';
  List<String> _selectedCategoryList = [];

  String get searchKeyword => _searchKeyword;

  List<String> get selectedCategoryList => _selectedCategoryList;

  Stream<QuerySnapshot> getPostSnapshots() {
    if (_selectedCategoryList.isEmpty) {
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

  set removeSelectedCategoryList(String value) {
    _selectedCategoryList.removeWhere((element) => element == value);
    notifyListeners();
  }

  void resetCategoryFilter() {
    _selectedCategoryList = [];
    notifyListeners();
  }
}
