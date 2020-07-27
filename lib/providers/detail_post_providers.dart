import 'package:flutter/foundation.dart';

class DetailPostProviders with ChangeNotifier {
  String _selectedOption = '';
  int _index = 0;

  String get selectedOption => _selectedOption;

  int get index => _index;

  set selectedOption(String value) {
    _selectedOption = value;
    notifyListeners();
  }

  set index(int value) {
    _index = value;
    notifyListeners();
  }
}
