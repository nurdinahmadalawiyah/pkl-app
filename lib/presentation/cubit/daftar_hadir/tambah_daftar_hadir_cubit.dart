import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:magang_app/common/constant.dart';
import 'package:magang_app/data/api/api_service.dart';
import 'package:magang_app/data/models/tambah_daftar_hadir_model.dart';
import 'package:signature/signature.dart';

part 'tambah_daftar_hadir_state.dart';

class TambahDaftarHadirCubit extends Cubit<TambahDaftarHadirState> {
  final ApiService apiService = ApiService();

  final hariTanggalController = TextEditingController();
  final mingguController = TextEditingController();
  final tandaTanganController = SignatureController(penStrokeWidth: 5, penColor: blackColor);

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

  void resetForm() {
    hariTanggalController.clear();
    mingguController.clear();
    tandaTanganController.clear();
  }
}
