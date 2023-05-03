import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:magang_app/data/api/api_service.dart';
import 'package:magang_app/data/models/login_model.dart';
import 'package:magang_app/data/models/register_model.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final FlutterSecureStorage storage = const FlutterSecureStorage();

  AuthCubit() : super(AuthInitial());

  void resetState() {
    emit(AuthInitial());
  }

  Future<void> loginPembimbing(String username, String password) async {
    emit(AuthLoading());
    try {
      final login = await ApiService().loginPembimbing(username, password);
      await storage.write(key: 'token', value: login.accessToken);
      await storage.write(key: 'role', value: login.role);
      emit(AuthLoginSuccess(login: login));
    } catch (e) {
      emit(AuthFailure(message: e.toString()));
    }
  }

  Future<void> logoutPembimbing(String token) async {
    emit(AuthLoading());
    try {
      await ApiService().logoutPembimbing();
      await storage.delete(key: 'token');
      await storage.delete(key: 'role');
      emit(AuthLogoutSuccess());
    } catch (e) {
      emit(AuthFailure(message: e.toString()));
    }
  }

  Future<void> registerPembimbing(String nama, String nik, String username, String password) async {
    emit(AuthRegisterLoading());
    try {
      final register = await ApiService().registerPembimbing(nama, nik, username, password);
      emit(AuthRegisterSuccess(register: register));
    } catch (e) {
      emit(AuthRegisterFailure(message: e.toString()));
    }
  }
}
