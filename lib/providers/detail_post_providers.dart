import 'package:flutter/foundation.dart';

class DetailPostProviders with ChangeNotifier {
  String _selectedOption = '';
  int _selectedIndex = 0;

  String get selectedOption => _selectedOption;

  int get selectedIndex => _selectedIndex;

  set selectedOption(String value) {
    _selectedOption = value;
    notifyListeners();
  }

  set selectedIndex(int value) {
    _selectedIndex = value;
    notifyListeners();
  }
}
