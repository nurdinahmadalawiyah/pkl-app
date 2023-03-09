import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:magang_app/data/api/api_service.dart';
import 'package:magang_app/data/models/profile_model.dart';

part 'profile_state.dart';

class ProfileCubit extends Cubit<ProfileState> {
  final ApiService apiService;

  ProfileCubit({required this.apiService}) : super(ProfileInitial()) {
    fetchProfile();
  }

  void fetchProfile() async {
    emit(ProfileLoading());
    try {
      final profile = await apiService.getProfile();
      emit(ProfileLoaded(profile: profile));
    } on SocketException {
      emit(ProfileNoConnection(message: "Tidak Ada Koneksi Internet"));
    } catch (e) {
      emit(ProfileError(message: e.toString()));
    }
  }
}