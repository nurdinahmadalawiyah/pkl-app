import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:magang_app/data/api/api_service.dart';
import 'package:magang_app/data/models/lowongan_pkl_model.dart';

part 'lowongan_pkl_state.dart';

class LowonganPklCubit extends Cubit<LowonganPklState> {
  final ApiService apiService;

  LowonganPklCubit({required this.apiService}) : super(LowonganPklInitial()) {
    getLowonganPkl();
  }

  void getLowonganPkl() async {
    emit(LowonganPklLoading());
    try {
      final lowonganPkl = await apiService.getLowonganPkl();
      if (lowonganPkl.data.isEmpty) {
        emit(const LowonganPklNoData(message: "Tidak Ada Lowongan PKL"));
      } else {
        emit(LowonganPklLoaded(lowonganPkl: lowonganPkl));
      }
    } on SocketException {
      emit(const LowonganPklNoConnections(message: "Tidak Ada Koneksi Internet"));
    } catch (e) {
      emit(LowonganPklError(message: e.toString()));
    }
  }
}
