import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:magang_app/data/api/api_service.dart';

part 'edit_profile_state.dart';

class EditProfileCubit extends Cubit<EditProfileState> {
  final ApiService _apiService = ApiService();

  final emailController = TextEditingController();
  final usernameController = TextEditingController();
  final tahunMasukController = TextEditingController();
  final nomorhpController = TextEditingController();

  EditProfileCubit() : super(EditProfileInitial());

  void resetState() {
    emit(EditProfileInitial());
  }

  Future<void> updateProfile(
    String email,
    String username,
    String tahunMasuk,
    String nomorHp,
  ) async {
    try {
      emit(EditProfileLoadingState());
      final response = await _apiService.updateProfile(
        email,
        username,
        tahunMasuk,
        nomorHp,
      );
      emit(const EditProfileSuccessState(editProfile: "Success"));
    } catch (e) {
      emit(EditProfileErrorState(message: e.toString()));
    }
  }

  void resetForm() {
    emailController.clear();
    usernameController.clear();
    tahunMasukController.clear();
    nomorhpController.clear();
  }
}
