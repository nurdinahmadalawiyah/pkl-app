import 'dart:io';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:magang_app/data/api/api_service.dart';
import 'package:magang_app/data/models/list_mahasiswa_model.dart';

part 'list_jurnal_kegiatan_state.dart';

class ListJurnalKegiatanCubit extends Cubit<ListJurnalKegiatanState> {
  final ApiService apiService;
  
  ListJurnalKegiatanCubit({required this.apiService}) : super(ListJurnalKegiatanInitial()) {
    getListJurnalKegiatan();
  }

  void getListJurnalKegiatan() async {
    emit(ListJurnalKegiatanLoading());
    try {
      final listMahasiswa = await apiService.getListJurnalKegiatan();
      if (listMahasiswa.data.isEmpty) {
        emit(const ListJurnalKegiatanNoData(message: "Data Kosong"));
      } else {
        emit(ListJurnalKegiatanLoaded(listMahasiswa: listMahasiswa));
      }
    } on SocketException {
      emit(const ListJurnalKegiatanNoConnection(message: "Tidak Ada Koneksi Interner"));
    } catch (e) {
      emit(ListJurnalKegiatanError(message: e.toString()));
    }
  }
}
