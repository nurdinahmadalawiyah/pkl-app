import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:magang_app/data/api/api_service.dart';
import 'package:magang_app/data/models/pengajuan_pkl_model.dart';

part 'pengajuan_pkl_state.dart';

class PengajuanPklCubit extends Cubit<PengajuanPklState> {
  final ApiService _apiService = ApiService();

  final namaPerusahaanController = TextEditingController();
  final alamatPerusahaanController = TextEditingController();
  final ditujukanController = TextEditingController();
  final tanggalMulaiController = TextEditingController();
  final tanggalSelesaiController = TextEditingController();

  PengajuanPklCubit() : super(PengajuanPklInitial());

  void resetState() {
    emit(PengajuanPklInitial());
  }

  Future<void> ajukanTempatPKL(
    String namaPerusahaan,
    String alamatPerusahaan,
    String ditujukan,
    String tanggalMulai,
    String tanggalSelesai,
  ) async {
    try {
      emit(PengajuanPklLoadingState());
      final response = await _apiService.ajukanTempatPKL(
        namaPerusahaan,
        alamatPerusahaan,
        ditujukan,
        tanggalMulai,
        tanggalSelesai,
      );
      emit(PengajuanPklSuccessState(pengajuanPkl: response));
    } catch (e) {
      emit(PengajuanPklErrorState(message: e.toString()));
    }
  }

  void resetForm() {
    namaPerusahaanController.clear();
    alamatPerusahaanController.clear();
    ditujukanController.clear();
    tanggalMulaiController.clear();
    tanggalSelesaiController.clear();
  }
}
