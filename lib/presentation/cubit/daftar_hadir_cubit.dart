import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:magang_app/data/api/api_service.dart';
import 'package:magang_app/data/models/daftar_hadir_model.dart';

part 'daftar_hadir_state.dart';

class DaftarHadirCubit extends Cubit<DaftarHadirState> {
  final ApiService apiService;
  
  DaftarHadirCubit({required this.apiService}) : super(DaftarHadirInitial()) {
    getDaftarHadir();
  }

  void getDaftarHadir() async {
    emit(DaftarHadirLoading());
    try {
      final daftarHadir = await apiService.getDaftarHadir();
      if (daftarHadir.data.isEmpty) {
        emit(const DaftarHadirNoData(message: "Daftar Hadir Kosong"));
      } else {
        emit(DaftarHadirLoaded(daftarHadir: daftarHadir));
      }
    } on SocketException {
      emit(const DaftarHadirNoConnections(message: "Tidak Ada Koneksi Internet"));
    } catch (e) {
      emit(DaftarHadirError(message: e.toString()));
    }
  }
}
