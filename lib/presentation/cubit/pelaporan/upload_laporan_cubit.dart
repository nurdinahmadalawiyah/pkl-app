import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:magang_app/data/api/api_service.dart';
import 'package:magang_app/data/models/upload_laporan_model.dart';

part 'upload_laporan_state.dart';

class UploadLaporanCubit extends Cubit<UploadLaporanState> {
  final ApiService apiService = ApiService();

  final fileController = TextEditingController();

  UploadLaporanCubit() : super(UploadLaporanInitial());

  void resetState() {
    emit(UploadLaporanInitial());
  }

  Future<void> uploadLaporan(File file) async {
    try {
      emit(UploadLaporanLoading());
      final response = await apiService.uploadLaporan(file);
      emit(UploadLaporanSuccess(uploadLaporan: response));
    } catch (e) {
      emit(UploadLaporanError(message: e.toString()));
    }
  }

  void resetForm() {
    fileController.clear();
  }
}
