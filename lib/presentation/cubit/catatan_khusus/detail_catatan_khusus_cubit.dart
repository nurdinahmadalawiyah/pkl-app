import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:magang_app/data/api/api_service.dart';
import 'package:magang_app/data/models/detail_catatan_khusus.dart';

part 'detail_catatan_khusus_state.dart';

class DetailCatatanKhususCubit extends Cubit<DetailCatatanKhususState> {
  final ApiService apiService;

  DetailCatatanKhususCubit({required this.apiService})
      : super(DetailCatatanKhususInitial());

  void getDetailCatatanKhusus(String idMahasiswa) async {
    emit(DetailCatatanKhususLoading());
    try {
      final catatanKhusus =
          await apiService.getDetailCatatanKhusus(idMahasiswa);
      if (catatanKhusus.data == null) {
        emit(const DetailCatatanKhususNoData(
            message: "Catatan Khusus PKL Kosong"));
      } else {
        emit(DetailCatatanKhususLoaded(catatanKhusus: catatanKhusus));
      }
    } on SocketException {
      emit(const DetailCatatanKhususNoConnection(
          message: "Tidak Ada Koneksi Internet"));
    } catch (e) {
      emit(
          const DetailCatatanKhususError(message: "Catatan Khusus PKL Kosong"));
    }
  }

  void resetState() {
    emit(DetailCatatanKhususInitial());
  }
}
