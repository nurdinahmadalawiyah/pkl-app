import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:magang_app/data/api/api_service.dart';
import 'package:magang_app/data/models/detail_jurnal_kegiatan_model.dart';
part 'detail_jurnal_kegiatan_state.dart';

class DetailJurnalKegiatanCubit extends Cubit<DetailJurnalKegiatanState> {
  final ApiService apiService;

  DetailJurnalKegiatanCubit({required this.apiService}) : super(DetailJurnalKegiatanInitial());

  void getDetailJurnalKegiatan(String idMahasiswa) async {
    emit(DetailJurnalKegiatanLoading());
    try {
      final jurnalKegiatan = await apiService.getDetailJurnalKegiatan(idMahasiswa);
      if (jurnalKegiatan.data.isEmpty) {
        emit(const DetailJurnalKegiatanNoData(message: "Jurnal Kegiatan Kosong"));
      } else {
        emit(DetailJurnalKegiatanLoaded(jurnalKegiatan: jurnalKegiatan));
      }
    } on SocketException {
      emit(const DetailJurnalKegiatanNoConnection(message: "Tidak Ada Koneksi Internet"));
    } catch (e) {
      emit(DetailJurnalKegiatanError(message: e.toString()));
      
    }
  }
}
