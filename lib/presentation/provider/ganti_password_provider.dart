import 'package:flutter/material.dart';
import 'package:magang_app/data/api/api_service.dart';
import 'package:magang_app/data/models/ganti_password_model.dart';

class GantiPasswordProvider extends ChangeNotifier {
  late GantiPassword _gantiPassword;

  GantiPassword get gantiPassword => _gantiPassword;

  set gantiPassword(GantiPassword gantiPassword) {
    _gantiPassword = gantiPassword;
    notifyListeners();
  }

  Future<bool> updatePassword({
    required String passwordLama,
    required String passwordBaru,
  }) async {
    try {
      GantiPassword gantiPassword = await ApiService().updatePassword(passwordLama, passwordBaru);
      _gantiPassword = gantiPassword;
      notifyListeners();
      return true;
    } catch (e) {
      return false;
    }
  }
}
