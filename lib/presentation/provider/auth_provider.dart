import 'package:flutter/cupertino.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:magang_app/data/api/api_service.dart';
import 'package:magang_app/data/models/login_model.dart';
import 'package:magang_app/data/models/logout_model.dart';

class AuthProvider extends ChangeNotifier {
  final FlutterSecureStorage storage = const FlutterSecureStorage();
  String? _token;
  late Login _login;
  late Logout _logout;

  Login get login => _login;
  Logout get logout => _logout;

  String? get token => _token;

  set login(Login login) {
    _login = login;
    notifyListeners();
  }

  set logout(Logout logout) {
    _logout = logout;
    notifyListeners();
  }

  Future<bool> authLogin({
    required String username,
    required String password,
  }) async {
    try {
      Login login = await ApiService().loginMahasiswa(username, password);
      _login = login;
      storage.write(key: 'token', value: login.accessToken);
      storage.write(key: 'role', value: login.role);
      notifyListeners();
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> authLogout({required String token}) async {
    try {
      Logout logout = await ApiService().logoutMahasiswa();
      _logout = logout;
      await storage.delete(key: 'token');
      _token = null;
      notifyListeners();
      return true;
    } catch (e) {
      return false;
    }
  }
}
