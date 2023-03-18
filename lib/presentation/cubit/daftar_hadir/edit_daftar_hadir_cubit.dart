import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:magang_app/common/constant.dart';
import 'package:magang_app/data/api/api_service.dart';
import 'package:magang_app/data/models/tambah_daftar_hadir_model.dart';
import 'package:signature/signature.dart';

part 'edit_daftar_hadir_state.dart';

class EditDaftarHadirCubit extends Cubit<EditDaftarHadirState> {
  final ApiService apiService = ApiService();

  final hariTanggalController = TextEditingController();
  final mingguController = TextEditingController();
  final tandaTanganController =
      SignatureController(penStrokeWidth: 5, penColor: blackColor);

  EditDaftarHadirCubit() : super(EditDaftarHadirInitial());

  void resetState() {
    emit(EditDaftarHadirInitial());
  }

  Future<void> updateDaftarHadir(
    String idDaftarHadir,
    String hariTanggal,
    String minggu,
    File tandaTangan,
  ) async {
    try {
      emit(EditDaftarHadirLoading());
      final response = await apiService.updateDaftarHadir(
        idDaftarHadir,
        hariTanggal,
        minggu,
        tandaTangan,
      );
      emit(EditDaftarHadirSuccess(editDaftarHadir: response));
    } catch (e) {
      emit(EditDaftarHadirError(message: e.toString()));
    }
  }

  void resetForm() {
    mingguController.clear();
    hariTanggalController.clear();
    tandaTanganController.clear();
  }
}
