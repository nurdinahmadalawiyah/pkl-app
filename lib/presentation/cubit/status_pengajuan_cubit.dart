import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/src/material/popup_menu.dart';
import 'package:magang_app/data/api/api_service.dart';
import 'package:magang_app/data/models/status_pengajuan_pkl_model.dart';

part 'status_pengajuan_state.dart';

class StatusPengajuanCubit extends Cubit<StatusPengajuanState> {
  final ApiService apiService;
  
  StatusPengajuanCubit({required this.apiService}) : super(StatusPengajuanInitial()) {
    getStatusPengajuan();
  }

  void getStatusPengajuan() async {
    emit(StatusPengajuanLoading());
    try {
      final statusPengajuanPkl = await apiService.getStatusPengajuan();
      if (statusPengajuanPkl == null) {
        emit(const StatusPengajuanNoData(message: "Tidak ada Pengajuan yang diajukan"));
      } else {
        emit(StatusPengajuanLoaded(statusPengajuanPkl: statusPengajuanPkl));
      }
    } on SocketException {
      emit(const StatusPengajuanNoConnection(message: "Tidak Ada Koneksi Internet"));
    } catch (e) {
      emit(StatusPengajuanError(message: e.toString()));
    }
  }
}
