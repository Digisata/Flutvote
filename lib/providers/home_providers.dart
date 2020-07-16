import 'package:flutter/foundation.dart';

class HomeProviders with ChangeNotifier {
  String _searchKeyword = '';
  int _selectedCategoryIndex = 0;

  String get searchKeyword => _searchKeyword;

  int get selectedCategoryIndex => _selectedCategoryIndex;

  set searchKeyword(String value) {
    _searchKeyword = value;
    notifyListeners();
  }

  set selectedCategoryIndex(int value) {
    _selectedCategoryIndex = value;
    notifyListeners();
  }
}
