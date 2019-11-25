import 'package:flutter/material.dart';

class UIState with ChangeNotifier {

  bool _signUpActive = false;
  bool _signInActive = true;

  bool get signUpActive => _signUpActive;
  bool get signInActive => _signInActive;

  void changeToSignUp() {
    _signUpActive = true;
    _signInActive = false;
    notifyListeners();
  }

  void changeToSignIn() {
    _signUpActive = false;
    _signInActive = true;
    notifyListeners();
  }
}
