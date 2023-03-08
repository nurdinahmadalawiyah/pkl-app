import 'package:flutter/material.dart';

class PasswordVisibilityProvider with ChangeNotifier {
  bool _passwordVisible = false;

  bool get passwordVisible => _passwordVisible;

  void toogle() {
    _passwordVisible = !_passwordVisible;
    notifyListeners();
  }
}