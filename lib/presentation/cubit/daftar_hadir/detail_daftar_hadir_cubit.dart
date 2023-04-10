import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:magang_app/data/api/api_service.dart';
import 'package:magang_app/data/models/daftar_hadir_model.dart';

part 'detail_daftar_hadir_state.dart';

class DetailDaftarHadirCubit extends Cubit<DetailDaftarHadirState> {
  final ApiService apiService;
  
  DetailDaftarHadirCubit({required this.apiService}) : super(DetailDaftarHadirInitial());

  void getDetailDaftarHadir(String idMahasiswa) async {
    emit(DetailDaftarHadirLoading());
    try {
      final daftarHadir = await apiService.getDetailDaftarHadir(idMahasiswa);
      if (daftarHadir.data.isEmpty) {
        emit(const DetailDaftarHadirNoData(message: "Daftar Hadir Kosong"));
      } else {
        emit(DetailDaftarHadirLoaded(daftarHadir: daftarHadir));
      }
    } on SocketException {
      emit(const DetailDaftarHadirNoConnection(message: "Tidak Ada Koneksi Internet"));
    } catch (e) {
      emit(DetailDaftarHadirError(message: e.toString()));
      
    }
  }
}
