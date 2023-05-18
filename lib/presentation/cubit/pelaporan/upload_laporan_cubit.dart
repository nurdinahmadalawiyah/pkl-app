import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:magang_app/data/api/api_service.dart';
import 'package:magang_app/data/models/cancel_laporan_model.dart';
import 'package:magang_app/data/models/upload_laporan_model.dart';

part 'upload_laporan_state.dart';

class UploadLaporanCubit extends Cubit<UploadLaporanState> {
  final ApiService apiService = ApiService();

  File? selectedFile;

  UploadLaporanCubit() : super(UploadLaporanInitial());

  void resetState() {
    emit(UploadLaporanInitial());
  }

  void selectFile(File file) {
    emit(state.copyWith(selectedFile: file));
  }

  void updateFile(File file) {
    selectedFile = file;
  }

  Future<void> uploadLaporan(File file) async {
    emit(UploadLaporanLoading());
    try {
      final response = await apiService.uploadLaporan(file);
      emit(UploadLaporanSuccess(laporan: response));
    } catch (e) {
      emit(UploadLaporanError(message: e.toString()));
    }
  }

  void getLaporan() async {
    emit(UploadLaporanLoading());
    try {
      final laporan = await apiService.getLaporan();
      // ignore: unnecessary_null_comparison
      if (laporan.data == null) {
        emit(UploadLaporanInitial());
      } else {
        emit(LaporanLoaded(laporan: laporan));
      }
    } on SocketException {
      emit(const LaporanNoConnection(message: "Tidak Ada Koneksi Interner"));
    } catch (e) {
      emit(LaporanError(message: e.toString()));
    }
  }

  Future<void> cancelLaporan(String idLaporan) async {
    try {
      emit(UploadLaporanInitial());
      final response = await apiService.cancelLaporan(idLaporan);
      emit(HapusLaporanSuccess(hapusLaporan: response));
    } catch (e) {
      emit(HapusLaporanError(message: e.toString()));
    }
  }

  void resetForm() {
    selectedFile = null;
  }
}
