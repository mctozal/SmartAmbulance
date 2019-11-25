import 'package:flutter/material.dart';

class SettingState with ChangeNotifier {
  bool _darkModeEnabled = false;
  bool get darkModeEnabled => _darkModeEnabled;
  void setTheme(_newValue) {
    _darkModeEnabled = _newValue;
    notifyListeners();
  }
}
