import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:magang_app/data/api/api_service.dart';
import 'package:magang_app/data/models/tambah_daftar_hadir_model.dart';

part 'tambah_daftar_hadir_state.dart';

class TambahDaftarHadirCubit extends Cubit<TambahDaftarHadirState> {
  final ApiService apiService = ApiService();

  TambahDaftarHadirCubit() : super(TambahDaftarHadirInitial());

  void resetState() {
    emit(TambahDaftarHadirInitial());
  }

  Future<void> addDaftarHadir(String hariTanggal, String minggu, File tandaTangan) async {
    try {
      emit(TambahDaftarHadirLoading());
      final response = await apiService.addDaftarHadir(hariTanggal, minggu, tandaTangan);
      emit(TambahDaftarHadirSuccess(tambahDaftarHadir: response));
    } catch (e) {
      emit(TambahDaftarHadirError(message: e.toString()));
    }
  }
}
