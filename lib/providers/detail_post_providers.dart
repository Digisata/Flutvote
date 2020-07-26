import 'package:flutter/foundation.dart';

class DetailPostProviders with ChangeNotifier {
  String _selectedOption = '';

  String get selectedOption => _selectedOption;

  set selectedOption(String value) {
    _selectedOption = value;
    notifyListeners();
  }
}
