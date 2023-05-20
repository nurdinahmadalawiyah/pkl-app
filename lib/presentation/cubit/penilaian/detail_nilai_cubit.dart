import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:magang_app/data/api/api_service.dart';
import 'package:magang_app/data/models/detail_nilai_model.dart';

part 'detail_nilai_state.dart';

class DetailNilaiCubit extends Cubit<DetailNilaiState> {
  final ApiService apiService;
  
  DetailNilaiCubit({required this.apiService}) : super(DetailNilaiInitial());

  void getDetailNilaiPkl(String idMahasiswa) async {
    emit(DetailNilaiLoading());
    try {
      final detailNilai = await apiService.getDetailNilaiPkl(idMahasiswa);
      if (detailNilai == null) {
        emit(const DetailNilaiNoData(message: "Data Nilai Kosong\nAnda Belum Memberikan Nilai"));
      } else {
        emit(DetailNilaiLoaded(detailNilai: detailNilai));
      }
    } on SocketException {
      emit(const DetailNilaiNoConnection(message: "Tidak Ada Koneksi Internet"));
    } catch (e) {
      emit(DetailNilaiError(message: e.toString()));
    }
  }
}
