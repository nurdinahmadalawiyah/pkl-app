import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:magang_app/data/api/api_service.dart';
import 'package:magang_app/data/models/catatan_khusus_model.dart';

part 'catatan_khusus_state.dart';

class CatatanKhususCubit extends Cubit<CatatanKhususState> {
  final ApiService apiService;

  CatatanKhususCubit({required this.apiService}) : super(CatatanKhususInitial()) {
    getCatatanKhusus();
  }

  void getCatatanKhusus() async {
    emit(CatatanKhususLoading());
    try {
      final catatanKhusus = await apiService.getCatatanKhusus();
      if (catatanKhusus == null) {
        emit(const CatatanKhususNoData(message: "Catatan Khusus PKL Kosong"));
      } else {
        emit(CatatanKhususLoaded(catatanKhusus: catatanKhusus));
      }
    } on SocketException {
      emit(const CatatanKhususNoConnection(message: "Tidak Ada Koneksi Internet"));
    } catch (e) {
      emit(const CatatanKhususError(message: "Catatan Khusus Kosong"));
    }
  }

  void resetCubit() {
    emit(CatatanKhususInitial());
  }
}
